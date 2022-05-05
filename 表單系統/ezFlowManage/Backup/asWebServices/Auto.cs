using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace asWebServices
{
    public partial class Auto : Form
    {
        public FlowDSTableAdapters.wfAbsAppMTableAdapter wfAbsAppMTA = new asWebServices.FlowDSTableAdapters.wfAbsAppMTableAdapter();
        public FlowDSTableAdapters.wfAbscAppMTableAdapter wfAbscAppMTA = new asWebServices.FlowDSTableAdapters.wfAbscAppMTableAdapter();
        public FlowDSTableAdapters.wfCardAppMTableAdapter wfCardAppMTA = new asWebServices.FlowDSTableAdapters.wfCardAppMTableAdapter();
        public FlowDSTableAdapters.wfOtAppMTableAdapter wfOtAppMTA = new asWebServices.FlowDSTableAdapters.wfOtAppMTableAdapter();
        public FlowDSTableAdapters.wfRepairAppMTableAdapter wfRepairAppMTA = new asWebServices.FlowDSTableAdapters.wfRepairAppMTableAdapter();

        public FlowDS oFlowDS;

        public Auto()
        {
            InitializeComponent();
        }

        private void Auto_Load(object sender, EventArgs e)
        {
            oFlowDS = new FlowDS();

            try
            {
                wfAbsAppMTA.FillByState3(oFlowDS.wfAbsAppM);
                wfAbscAppMTA.FillByState3(oFlowDS.wfAbscAppM);
                wfCardAppMTA.FillByState3(oFlowDS.wfCardAppM);
                wfOtAppMTA.FillByState3(oFlowDS.wfOtAppM);
                wfRepairAppMTA.FillByState3(oFlowDS.wfRepairAppM);

                DynamicSrv.Service oService = new asWebServices.DynamicSrv.Service();

                oService.Url = new AbsWS.AbsWS().Url;
                //wfAbsAppMTA.Update((FlowDS.wfAbsAppMDataTable)RunWS(oFlowDS.wfAbsAppM, oService));
                RunWS(oFlowDS.wfAbsAppM, oService);

                oService.Url = new AbscWS.AbscWS().Url;
                //wfAbscAppMTA.Update((FlowDS.wfAbscAppMDataTable)RunWS(oFlowDS.wfAbscAppM, oService));
                RunWS(oFlowDS.wfAbscAppM, oService);

                oService.Url = new CardWS.CardWS().Url;
                //wfCardAppMTA.Update((FlowDS.wfCardAppMDataTable)RunWS(oFlowDS.wfCardAppM, oService));
                RunWS(oFlowDS.wfCardAppM, oService);

                oService.Url = new OtWS.OtWS().Url;
                //wfOtAppMTA.Update((FlowDS.wfOtAppMDataTable)RunWS(oFlowDS.wfOtAppM, oService));
                RunWS(oFlowDS.wfOtAppM, oService);

                oService.Url = new RepairWS.RepairWS().Url;
                //wfRepairAppMTA.Update((FlowDS.wfRepairAppMDataTable)RunWS(oFlowDS.wfRepairAppM, oService));
                RunWS(oFlowDS.wfRepairAppM, oService);
            }
            catch (Exception ex)
            {
                CreateTextFile("C:\\FlowError\\asWebServices" + DateTime.Now.ToFileTime().ToString() + ".txt", ex.ToString());
                //throw ex;
            }

            Close();
        }

        public static void CreateTextFile(string sFileName, string sError)
        {
            StreamWriter sw = File.CreateText(@sFileName);
            sw.Write(sError);
            sw.Close();
        }

        public DataTable RunWS(DataTable dt, DynamicSrv.Service ws)
        {
            foreach (DataRow r in dt.Rows)
            {
                System.Threading.Thread.Sleep(2000);
                ws.Run(Convert.ToInt32(r["idProcess"]));
                //r["sState"] = "6";
            }

            return dt;
        }
    }
}