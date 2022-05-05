using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI.WebControls;

namespace sa {
	public class gv {
		public static void RowDataBoundColorChange(GridViewRowEventArgs e) {
			if(e.Row.RowType == DataControlRowType.DataRow) {
				//滑鼠移至資料列上的顏色
				e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFFFC7'");
				//滑鼠點擊後變色
				e.Row.Attributes.Add("onclick", "this.style.backgroundColor='#FF9933'");
				//e.Row.Attributes.Add("onclick", "window.location.href='Login.aspx'");
				if(e.Row.RowState == DataControlRowState.Alternate) {
					//滑鼠離開資料列上的顏色
					e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='White'");
				}
				else if(e.Row.RowState == DataControlRowState.Normal) {
					//滑鼠離開資料列上的顏色
                    e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#F2F2F2'");
				}
			}
		}

		//匯出xls
		public static void ExportXls(GridView gv) {
            string FileName = gv.ID + "-" + Guid.NewGuid().ToString() + ".xls";

            for (int i = 0; i < gv.Rows.Count; i++)
                for (int j = 0; j < gv.Columns.Count - 1; j++)
                    gv.Rows[i].Cells[j].Attributes.Add("class", "xlString");

			System.Web.HttpContext.Current.Response.Clear();
			System.Web.HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + FileName);
			System.Web.HttpContext.Current.Response.ContentType = "application/ms-excel";
			System.IO.StringWriter stringWrite = new System.IO.StringWriter();
			System.Web.UI.HtmlTextWriter htmlWrite = new System.Web.UI.HtmlTextWriter(stringWrite);
			gv.RenderControl(htmlWrite);
			string strStyle = "<style>.xlString { mso-number-format:\\@; } </style>";
			System.Web.HttpContext.Current.Response.Write(strStyle);
			System.Web.HttpContext.Current.Response.Write(stringWrite.ToString());
			System.Web.HttpContext.Current.Response.End();
		}
	}
}
