using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowFrom
{
    /// <summary>
    /// Tools 的摘要描述
    /// </summary>
    public   class Tools
    {
        public Tools() { }

        public static string GetFlowImageUrl(string Case, string NobrM = "", string NobrS = "", string ProcessID = "", string Key1 = "", string Key2 = "")
        {
            dcFlowDataContext dcFlow = new dcFlowDataContext();

            string DialogPage = "../Etc/ProcessFlow.aspx";

            string ValidateKey = Guid.NewGuid().ToString();

            string DialogParm = "NobrM=" + NobrM + "&NobrS=" + NobrS + "&ValidateKey=" + ValidateKey + "&ProcessID=" + ProcessID + "&Key1=" + Key1 + "&Key2=" + Key2;
            string DialogParmDetail = "";

            switch (Case)
            {
                case "Std":
                    break;
                default:
                    break;
            }

            DialogParm = Bll.Tools.Decryption.Encrypt(DialogParm + DialogParmDetail);

            var r = new wfWebValidate();
            r.sValidateKey = ValidateKey;
            r.dDateWriter = DateTime.Now;
            r.sParm = DialogParm;
            dcFlow.wfWebValidate.InsertOnSubmit(r);
            dcFlow.SubmitChanges();

            return DialogPage + "?Parm=" + DialogParm;
        }
    }
}