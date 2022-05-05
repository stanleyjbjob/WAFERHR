using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// SaveAbs 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下一行。
// [System.Web.Script.Services.ScriptService]
public class SaveAbs : System.Web.Services.WebService
{
    public SaveAbs()
    {

        //如果使用設計的元件，請取消註解下行程式碼 
        //InitializeComponent(); 
    }

    [WebMethod]
    public bool Run(int ID)
    {
        dcHRDataContext dcHR = new dcHRDataContext();
        dcFlowDataContext dcFlow = new dcFlowDataContext();
        dcFormDataContext dcForm = new dcFormDataContext();

        int ProcessID = ID;
        ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);

        var rGetApView = oService.GetApView(ID);
        ProcessID = rGetApView.ProcessFlow_id;

        var rAppM = (from c in dcFlow.wfFormApp
                     where c.idProcess == ProcessID
                     select c).FirstOrDefault();

        var rsAppS = (from c in dcForm.wfAppAbs
                      where c.idProcess == ProcessID
                      select c).ToList();

        var rsAppInfo = (from c in dcFlow.wfFormAppInfo
                         where c.idProcess == ProcessID
                         select c).ToList();

        if (rAppM == null || rsAppS.Count == 0)
            return false;

        //表單流程結束記號
        rAppM.sState = rAppM.bSign ? "3" : rAppM.sState;

        List<string> lsNobr = new List<string>();
        lsNobr.Add(rAppM.sNobr);
        lsNobr.AddRange(rsAppS.Select(p => p.sNobr));

        var rsFormSignM = (from c in dcFlow.wfFormSignM
                           where c.idProcess == ProcessID
                           orderby c.dKeyDate
                           select c).ToList();

        var rsEmp = (from c in dcFlow.Emp
                     where lsNobr.Contains(c.id)
                     select c).ToList();

        string sSignNote = "";
        foreach (var rFormSignM in rsFormSignM)
            sSignNote += "<BR>" + rFormSignM.sName + "：" + rFormSignM.sNote;

        Dal.Dao.Att.AbsDao oAbsDao = new Dal.Dao.Att.AbsDao(dcHR.Connection);
        Dal.Dao.Att.OtDao oOtDao = new Dal.Dao.Att.OtDao(dcHR.Connection);

        string sSubject = "【通知】(" + rAppM.sNobr + ")" + rAppM.sName + " 之請假單";
        string sBody = "";

        List<string> lsSendMail = new List<string>();

        var rEmp = (from c in rsEmp
                    where c.id == rAppM.sNobr
                    select c).FirstOrDefault();

        //if (rEmp != null && rEmp.email.Trim().Length > 0 && !lsSendMail.Contains(rEmp.email))
        //    lsSendMail.Add(rEmp.email);

        foreach (var rAppS in rsAppS)
        {
            if (rAppS.bSign)
            {
                int iPass = 0;
                if (rAppS.sFormCode == "Abs")
                    iPass = oAbsDao.AbsSave(rAppS.sNobr, rAppS.sHcode, rAppS.dDateB, rAppS.dDateE, rAppS.sTimeB, rAppS.sTimeE, rAppS.sNote, rAppM.sName, "", rAppM.sProcessID, "", "", true, true, 0, false, "", true);
                else
                    iPass = oAbsDao.AbsSave(rAppS.sNobr, rAppS.sHcode, rAppS.dDateB, rAppS.dDateE, rAppS.sTimeB, rAppS.sTimeE, rAppS.sNote, rAppM.sName, "", rAppM.sProcessID, "", "", false, true, 0, false, "", true);

                rAppS.sState = "3";
            }

            sBody += ("<font size='5' color='red'>此筆資料" + (rAppS.sState == "3" ? "核准</font>" : "駁回</font>")) + rAppS.sMailBody + "<BR><BR>";

            rEmp = (from c in rsEmp
                    where c.id == rAppS.sNobr
                    select c).FirstOrDefault();

            //啟動代理日期
            if (rEmp != null)
            {
                rEmp.dateB = rAppS.dDateTimeB;
                rEmp.dateE = rAppS.dDateTimeE;
            }

            if (!rAppS.bSign)
                if (rEmp != null && rEmp.email.Trim().Length > 0 && !lsSendMail.Contains(rEmp.email))
                    lsSendMail.Add(rEmp.email);

            //Info狀態改變
            var rAppInfo = rsAppInfo.Where(p => p.idProcess == rAppS.idProcess).FirstOrDefault();
            if (rAppInfo != null)
                rAppInfo.sState = rAppS.sState;
        }

        if (sBody.Length > 0)
        {
            foreach (var s in lsSendMail)
            {
                var rSendMail = new wfSendMail();
                rSendMail.sProcessID = ProcessID.ToString();
                rSendMail.idProcess = Convert.ToInt32(rSendMail.sProcessID);
                rSendMail.sGuid = Guid.NewGuid().ToString();
                rSendMail.sToAddress = s;
                rSendMail.sSubject = sSubject;
                rSendMail.sBody = sBody;
                rSendMail.bOnly = true;
                rSendMail.sKeyMan = rAppM.sNobr;
                rSendMail.dKeyDate = DateTime.Now;
                dcFlow.wfSendMail.InsertOnSubmit(rSendMail);
            }
        }

        dcForm.SubmitChanges();
        dcFlow.SubmitChanges();

        return true;
    }
}