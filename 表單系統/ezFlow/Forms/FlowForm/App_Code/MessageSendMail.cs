using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// MessageSendMail 的摘要描述
/// </summary>
public static class MessageSendMail
{
    public static string AbsBody(string sNobr, string sName, string sDeptName, string sHcodeName,
                DateTime dDateB, string sTimeB, DateTime dDateE, string sTimeE, decimal iUse, string sUnit, string sNote, string sAgentNote)
    {
        string sBody = "<BR>工　　號：" + sNobr +
                       "<BR>姓　　名：" + sName +
                       "<BR>部　　門：" + sDeptName +
                       "<BR>假　　別：" + sHcodeName +
                       "<BR>起始日期：" + dDateB.ToShortDateString() +
                       "<BR>起始時間：" + sTimeB +
                       "<BR>結束日期：" + dDateE.ToShortDateString() +
                       "<BR>結束時間：" + sTimeE +
                       "<BR>總計：" + iUse.ToString() + sUnit +
                       "<BR>申請原因：" + sNote +
                       "<BR>交辦事項：" + sAgentNote +
                       "<BR><BR>";

        return sBody;
    }

    //銷假申請待簽核
    public static string AbscBody(string sNobr, string sName, string sDeptName, string sHcodeName,
     DateTime dDate, string sTime, decimal iHour,string sUnit, string sNote)
    {
        string sBody = "<BR>工　　號：" + sNobr +
                       "<BR>姓　　名：" + sName +
                       "<BR>部　　門：" + sDeptName +
                       "<BR>假　　別：" + sHcodeName +
                       "<BR>日　　期：" + dDate.ToShortDateString() +
                       "<BR>時　　間：" + sTime +
                       "<BR>總　　計：" + iHour.ToString() + sUnit + 
                       "<BR>申請原因：" + sNote +
                       "<BR><BR>";

        return sBody;
    }

    //調班單申請待簽核
    public static string ShiftLongBody(string sNobr, string sName, string sDeptName, string sRotetNameA, DateTime dDate, string sRotetNameB, string sNote)
    {
        string sBody = "<BR>工　　號：" + sNobr +
                       "<BR>姓　　名：" + sName +
                       "<BR>部　　門：" + sDeptName +
                       "<BR>目前班別：" + sRotetNameA +
                       "<BR>調班後日期：" + dDate.ToShortDateString() +
                       "<BR>調班後班別：" + sRotetNameB +
                       "<BR>申請原因：" + sNote +
                       "<BR><BR>";

        return sBody;
    }

    //換班單申請待簽核
    public static string ShiftShortBody(string sNobr, string sName, string sDeptName,
        string sRotetNameA, DateTime dDateA, string sRotetNameB, DateTime dDateB, string sNote)
    {
        string sBody = "<BR>工　　號：" + sNobr +
                       "<BR>姓　　名：" + sName +
                       "<BR>部　　門：" + sDeptName +
                       "<BR>原日期" + dDateA.ToShortDateString() +
                       "<BR>原班別：" + sRotetNameA +
                       "<BR>換班後日期：" + dDateB.ToShortDateString() +
                       "<BR>換班後班別：" + sRotetNameB +
                       "<BR>申請原因：" + sNote +
                       "<BR><BR>";

        return sBody;
    }

    //換班單天
    public static string ShiftDayBody(string sNobr, string sName, string sDeptName,
      DateTime dDate, int iMinutes, string sNote)
    {
        string sBody = "<BR>工　　號：" + sNobr +
                       "<BR>姓　　名：" + sName +
                       "<BR>部　　門：" + sDeptName +
                       "<BR>日期：" + dDate.ToShortDateString() +
                       "<BR>時間：" + iMinutes.ToString() +
                       "<BR>申請原因：" + sNote +
                       "<BR><BR>";

        return sBody;
    }

    //加班單申請待簽核
    public static string OtBody(string sNobr, string sName, string sDeptName,
     string sOtRoteName, DateTime dDate, string sTimeB, string sTimeE, decimal iHour, string sOtCatName, string sNote)
    {
        string sBody = "<BR>工　　號：" + sNobr +
                       "<BR>姓　　名：" + sName +
                       "<BR>部　　門：" + sDeptName +
                       "<BR>目前班別：" + sOtRoteName +
                       "<BR>加班日期：" + dDate.ToShortDateString() +
                       "<BR>加班時間：" + sTimeB + "-" + sTimeE +
                       "<BR>總時數：" + iHour + "小時" +
                       "<BR>給付方式 ：" + sOtCatName +
                       "<BR>申請原因：" + sNote +
                       "<BR><BR>";

        return sBody;
    }

    //預估加班單申請待簽核
    public static string Ot1Body(string sNobr, string sName, string sDeptName,
     string sOtRoteName, DateTime dDate, string sTimeB, string sTimeE, decimal iHour, string sOtCatName, string sNote)
    {
        string sBody = "<BR>工　　號：" + sNobr +
                       "<BR>姓　　名：" + sName +
                       "<BR>部　　門：" + sDeptName +
                       "<BR>目前班別：" + sOtRoteName +
                       "<BR>預估加班日期：" + dDate.ToShortDateString() +
                       "<BR>預估加班時間：" + sTimeB + "-" + sTimeE +
                       "<BR>總時數：" + iHour + "小時" +
                       "<BR>申請原因：" + sNote +
                       "<BR><BR>";

        return sBody;
    }

    //忘刷申請待簽核
    public static string CardBoy(string sNobr, string sName, string sDeptName, DateTime dDate, string sTime, string sNote)
    {
        string sBody = "<BR>工　　號：" + sNobr +
                       "<BR>姓　　名：" + sName +
                       "<BR>部　　門：" + sDeptName +
                       "<BR>日期：" + dDate.ToShortDateString() +
                       "<BR>時間：" + sTime +
                       "<BR>申請原因：" + sNote +
                        "<BR><BR>";

        return sBody;
    }
}