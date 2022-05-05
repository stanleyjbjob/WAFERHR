using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// AbsMessage 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下一行。
// [System.Web.Script.Services.ScriptService]
public class AbsMessage : System.Web.Services.WebService
{

    public AbsMessage() { }

    [WebMethod]
    public bool Run(int ID)
    {
        //dcHRDataContext dcHR = new dcHRDataContext();
        //dcFlowDataContext dcFlow = new dcFlowDataContext();
        //dcFormDataContext dcForm = new dcFormDataContext();

        //int ProcessID = ID;
        //ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);

        //var rGetApView = oService.GetApView(ID);
        //ProcessID = rGetApView.ProcessFlow_id;

        //var rAppM = (from c in dcFlow.wfFormApp
        //             where c.idProcess == ProcessID
        //             select c).FirstOrDefault();

        //var rsAppS = (from c in dcForm.wfAppAbs
        //              where c.idProcess == ProcessID
        //              select c).ToList();

        //var rsAppInfo = (from c in dcFlow.wfFormAppInfo
        //                 where c.idProcess == ProcessID
        //                 select c).ToList();

        //if (rAppM == null || rsAppS.Count == 0)
        //    return false;

        //List<string> lsNobr = new List<string>();
        //lsNobr.Add(rAppM.sNobr);

        //foreach (var rAppS in rsAppS)
        //{
        //    if (!lsNobr.Contains(rAppS.sNobr))
        //        lsNobr.Add(rAppS.sNobr);

        //    if (rAppS.sAgentNobr.Length > 0 && !lsNobr.Contains(rAppS.sAgentNobr))
        //        lsNobr.Add(rAppS.sAgentNobr);
        //}

        //var rsFormSignM = (from c in dcFlow.wfFormSignM
        //                   where c.idProcess == ProcessID
        //                   orderby c.dKeyDate
        //                   select c).ToList();

        //var rsEmp = (from c in dcFlow.Emp
        //             where lsNobr.Contains(c.id)
        //             select c).ToList();

        //string sSignNote = "";
        //foreach (var rFormSignM in rsFormSignM)
        //    sSignNote += "<BR>" + rFormSignM.sName + "：" + rFormSignM.sNote;

        //string sSubject = "【通知】(" + rAppM.sNobr + ")" + rAppM.sName + " 之請假單";
        //string sBody = "";

        //List<string> lsSendMail = new List<string>();

        //var rEmp = (from c in rsEmp
        //            where c.id == rAppM.sNobr
        //            select c).FirstOrDefault();

        ////加入申請者的信箱
        //if (rEmp != null && rEmp.email.Trim().Length > 0 && !lsSendMail.Contains(rEmp.email))
        //    lsSendMail.Add(rEmp.email);

        //foreach (var rAppS in rsAppS)
        //{
        //    sBody = ("此筆資料" + (rAppS.bSign ? "核准" : "駁回")) + rAppS.sMailBody + "<BR><BR>";

        //    rEmp = (from c in rsEmp
        //            where c.id == rAppS.sNobr
        //            select c).FirstOrDefault();

        //    //加入被申請者的信箱
        //    if (rEmp != null && rEmp.email.Trim().Length > 0 && !lsSendMail.Contains(rEmp.email))
        //        lsSendMail.Add(rEmp.email);

        //    if (rAppS.bSign)
        //    {
        //        //核准通知給代理人
        //        if (rAppS.sAgentNobr != null && rAppS.sAgentNobr.Trim().Length > 0)
        //        {
        //            rEmp = (from c in rsEmp
        //                    where c.id == rAppS.sAgentNobr
        //                    select c).FirstOrDefault();

        //            if (rEmp != null && rEmp.email.Trim().Length > 0)
        //            {
        //                var rSendMail = new wfSendMail();
        //                rSendMail.sProcessID = ProcessID.ToString();
        //                rSendMail.idProcess = Convert.ToInt32(rSendMail.sProcessID);
        //                rSendMail.sGuid = Guid.NewGuid().ToString();
        //                rSendMail.sToAddress = rEmp.email;
        //                rSendMail.sSubject = sSubject + "-職務代理人";
        //                rSendMail.sBody = sBody;
        //                rSendMail.bOnly = true;
        //                rSendMail.sKeyMan = rAppM.sNobr;
        //                rSendMail.dKeyDate = DateTime.Now;
        //                dcFlow.wfSendMail.InsertOnSubmit(rSendMail);
        //            }
        //        }
        //    }
        //}

        //if (sBody.Length > 0)
        //{
        //    foreach (var s in lsSendMail)
        //    {
        //        var rSendMail = new wfSendMail();
        //        rSendMail.sProcessID = ProcessID.ToString();
        //        rSendMail.idProcess = Convert.ToInt32(rSendMail.sProcessID);
        //        rSendMail.sGuid = Guid.NewGuid().ToString();
        //        rSendMail.sToAddress = s;
        //        rSendMail.sSubject = sSubject;
        //        rSendMail.sBody = sBody;
        //        rSendMail.bOnly = true;
        //        rSendMail.sKeyMan = rAppM.sNobr;
        //        rSendMail.dKeyDate = DateTime.Now;
        //        dcFlow.wfSendMail.InsertOnSubmit(rSendMail);
        //    }
        //}

        //dcForm.SubmitChanges();
        //dcFlow.SubmitChanges();

        return true;
    }
}