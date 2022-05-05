using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace jbmodule
{
	public enum ItemListType { Text, ValueAndText };
	public enum ScriptMsgType { Alert, Confirm };
}

namespace jbmodule.Web
{
	public class ui
	{
        private static Control FindControl(ControlCollection controls, string ctrl_id)
        {
            Control get_ctrl = null;

            foreach (Control control in controls)
            {
                if (control.ID == ctrl_id)
                {
                    get_ctrl = control;
                    break;
                }
                else
                {
                    if (control.Controls.Count > 0)
                    {
                        get_ctrl = FindControl(control.Controls, ctrl_id);
                        if (get_ctrl != null) break;
                    }
                }
            }

            return get_ctrl;
        }

		public static void ShowDataRowToUI(Page page, DataRow dataRow) {			
			foreach (DataColumn dataColumn in dataRow.Table.Columns) {
				string ctrl_id = "data_" + dataColumn.ColumnName;
				Control control = FindControl(page.Controls, ctrl_id);
				if (control is Label) {
					if (dataColumn.DataType == typeof(DateTime)) {
						string[] spStr = Convert.ToDateTime(dataRow[dataColumn]).ToString((control as Label).ToolTip).Split(new char[] { '/' });
						string date = Convert.ToString(Convert.ToInt32(spStr[0]) - 1911) + "/" + spStr[1] + "/" + spStr[2];
						(control as Label).Text = date;
					}
					else {
						(control as Label).Text = dataRow[dataColumn].ToString();
					}
				}
				if (control is TextBox) {
					if (dataColumn.DataType == typeof(DateTime)) {
						string[] spStr = Convert.ToDateTime(dataRow[dataColumn]).ToString((control as TextBox).ToolTip).Split(new char[] { '/' });
						string date = Convert.ToString(Convert.ToInt32(spStr[0]) - 1911) + "/" + spStr[1] + "/" + spStr[2];
						(control as TextBox).Text = date;
					}
					else {
						(control as TextBox).Text = dataRow[dataColumn].ToString();
					}
				}
				if (control is CheckBox) {
					if (Convert.ToBoolean(dataRow[dataColumn])) {
						(control as CheckBox).Checked = true;
					}
					else {
						(control as CheckBox).Checked = false;
					}
				}
				if (control is DropDownList) {
					foreach (ListItem listItem in (control as DropDownList).Items) listItem.Selected = false;
					foreach (ListItem listItem in (control as DropDownList).Items) {
						if (listItem.Value == dataRow[dataColumn].ToString()) {
							listItem.Selected = true;
							break;
						}
					}
				}
				if (control is RadioButtonList) {
					foreach (ListItem listItem in (control as RadioButtonList).Items) listItem.Selected = false;
					foreach (ListItem listItem in (control as RadioButtonList).Items) {
						if (listItem.Value == dataRow[dataColumn].ToString()) {
							listItem.Selected = true;
							break;
						}
					}
				}
			}
		}

		public static void SetDropDownList(Control control, string[] items) {
			foreach (string item in items) {
				(control as DropDownList).Items.Add(new ListItem(item, item));
			}
		}

		public static void SetDropDownList(Control control, ItemListType itemListType, DataTable dataTable, string DataValueField, string DataTextField) {
			foreach (DataRow dataRow in dataTable.Rows) {
				if (itemListType == ItemListType.ValueAndText) {
					(control as DropDownList).Items.Add(new ListItem(dataRow[DataValueField].ToString() + ", " + dataRow[DataTextField].ToString(), dataRow[DataValueField].ToString()));
				}
				else {
					(control as DropDownList).Items.Add(new ListItem(dataRow[DataTextField].ToString(), dataRow[DataValueField].ToString()));
				}
			}
		}

		public static void SetRadioButtonList(Control control, string[] items) {
			foreach (string item in items) {
				(control as RadioButtonList).Items.Add(new ListItem(item, item));
			}
		}

		public static void SetRadioButtonList(Control control, ItemListType itemListType, DataTable dataTable, string DataValueField, string DataTextField) {
			foreach (DataRow dataRow in dataTable.Rows) {
				if (itemListType == ItemListType.ValueAndText) {
					(control as RadioButtonList).Items.Add(new ListItem(dataRow[DataValueField].ToString() + ", " + dataRow[DataTextField].ToString(), dataRow[DataValueField].ToString()));
				}
				else {
					(control as RadioButtonList).Items.Add(new ListItem(dataRow[DataTextField].ToString(), dataRow[DataValueField].ToString()));
				}
			}
		}

		public static void SetInputEvent(ControlCollection controls) {			
			foreach (Control control in controls) {
				if (control is WebControl) {
					if (!(control is Button)) {
						(control as WebControl).Attributes.Add("onkeydown", "ReturnTab()");
					}
				}
				if (control is TextBox) {					
					if ((control as TextBox).ToolTip == "yyyy/MM/dd") {
						(control as TextBox).Attributes.Add("onkeyup", "date_format('" + control.ClientID + "')");						
					}
				}
				else {
					if (control.Controls.Count > 0) {						
						SetInputEvent(control.Controls);						
					}
				}
			}			
		}

        public static string DateFormatScript()
        {
            string script =
                "function date_format(id) {\n" +
                "	if((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode == 191 || event.keyCode == 111) {\n" +
                "	val = new String(document.getElementById(id).value);\n" +
                "		if(val.length == 4) {\n" +
                "			year = new Number(val);\n" +
                "			if(year > 0) {\n" +
                "				year = year - 0;\n" +
                "				if(year < 100) document.getElementById(id).value = '00' + year + '/';\n" +
                "				else if(year >= 100 && year < 1000) document.getElementById(id).value = '0' + year + '/';\n" +
                "				else document.getElementById(id).value = year + '/';\n" +
                "			}\n" +
                "			else {\n" +
                "				if(val.indexOf('/',0) != -1) {\n" +
                "					spStr = val.split('/');\n" +
                "					year = new Number(spStr[0]);\n" +
                "					if(year <= 0) {\n" +
                "						if(year < 100) spStr[0] = '00' + year;\n" +
                "						else spStr[0] = '0' + year;\n" +
                "						document.getElementById(id).value = spStr[0] + '/';\n" +
                "					}\n" +
                "				}\n" +
                "				else {\n" +
                "					sYear = new String(year);\n" +
                "					if(year <= 0) {\n" +
                "						if(year < 100) sYear = '00' + year;\n" +
                "						else sYear = '0' + year;\n" +
                "					}\n" +
                "					document.getElementById(id).value = sYear + '/';\n" +
                "				}\n" +
                "			}\n" +
                "		}\n" +
                "		else {\n" +
                "			if(val.indexOf('/',0) != -1) {\n" +
                "				spStr = val.split('/');\n" +
                "				year = new Number(spStr[0]);\n" +
                "				if(year <= 0) {\n" +
                "					if(year < 100) spStr[0] = '00' + year;\n" +
                "					else spStr[0] = '0' + year;\n" +
                "				}\n" +
                "				if(spStr.length == 2) {\n" +
                "					if(spStr[1].length > 0) {\n" +
                "						if(spStr[1] == '01') {\n" +
                "							document.getElementById(id).value = spStr[0] + '/01/';\n" +
                "						}\n" +
                "						else {\n" +
                "							month = new Number(spStr[1]);\n" +
                "							if(month >= 2 && month <= 12) {\n" +
                "								if(month >= 2 && month <= 9) {\n" +
                "									document.getElementById(id).value = spStr[0] + '/0' + month + '/';\n" +
                "								}\n" +
                "								else {\n" +
                "									document.getElementById(id).value = spStr[0] + '/' + month + '/';\n" +
                "								}\n" +
                "							}\n" +
                "							else {\n" +
                "								if(month > 1) {\n" +
                "									document.getElementById(id).value = spStr[0] + '/01/3';\n" +
                "								}\n" +
                "							}\n" +
                "						}\n" +
                "					}\n" +
                "					else {\n" +
                "						document.getElementById(id).value = spStr[0] + '/';\n" +
                "					}\n" +
                "				}\n" +
                "				if(spStr.length == 3) {\n" +
                "					var month = new Number(spStr[1]);\n" +
                "					if(month >=1 && month <= 9) spStr[1] = '0' + month;\n" +
                "					var day = new Number(spStr[2]);\n" +
                "					if(day > 0) {\n" +
                "						year = new Number(spStr[0]);\n" +
                "						if (year <= 0) year = year + 0;\n" +
                "						date = new Date(year, month, 0);\n" +
                "						var days = date.getDate();\n" +
                "						if(day > days) day = days;\n" +
                "						if(day <= 9) {\n" +
                "							document.getElementById(id).value = spStr[0] + '/' + spStr[1] + '/0' + day;\n" +
                "						}\n" +
                "						else {\n" +
                "							document.getElementById(id).value = spStr[0] + '/' + spStr[1] + '/' + day;\n" +
                "						}\n" +
                "					}\n" +
                "					else {\n" +
                "						document.getElementById(id).value = spStr[0] + '/' + spStr[1] + '/';\n" +
                "					}\n" +
                "				}\n" +
                "			}\n" +
                "		}\n" +
                "	}\n" +
                "	else {\n" +
                "		if(event.keyCode != 8) {\n" +
                "			str = new String(document.getElementById(id).value);\n" +
                "			document.getElementById(id).value = str.substr(0,str.length - 1);\n" +
                "		}\n" +
                "	}\n" +
                "}\n" +
                "function ReturnTab() {\n" +
                "	if(event.keyCode == 13) event.keyCode = 9;\n" +
                "}\n";

            return script;
        }
	}
}
