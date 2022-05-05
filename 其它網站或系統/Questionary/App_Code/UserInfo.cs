using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Net;
using System.Management;

namespace sa {
	public class UserInfo {
		private string macAddress;
		private string ipAddress;

		public UserInfo() {
			GetServerMacIP();
		}

		//取得Client端的IP位址
		public static string GetClientIP() {
			string strIpAddr = string.Empty;
			if(HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null || HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].IndexOf("unknown") > 0) {
				strIpAddr = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
			}
			else if(HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].IndexOf(",") > 0) {
				strIpAddr = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].Substring(1, HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].IndexOf(",") - 1);
			}
			else if(HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].IndexOf(";") > 0) {
				strIpAddr = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].Substring(1, HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].IndexOf(";") - 1);
			}
			else {
				strIpAddr = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
			}

			return strIpAddr;
		}

		//取得Server端的IP位址
		public static IPAddress[] GetServerIP() {
			return Dns.GetHostByName(Dns.GetHostName()).AddressList;
		}

		//取得Server端的MAC及IP位址
		private void GetServerMacIP() {
			string sMAC = ",";
			string sIP = ",";

			ManagementClass MC = new ManagementClass("Win32_NetworkAdapterConfiguration"); 
			ManagementObjectCollection MOC = MC.GetInstances();

			foreach(ManagementObject MO in MOC) {
				if((bool)MO["IPEnabled"] == true) {
					sMAC += MO["MACAddress"].ToString() + ",";
					string[] IPAddresses = (string[])MO["IPAddress"];
					if(IPAddresses.Length > 0)
						sIP += IPAddresses[0] + ",";
				}
			}

			this.macAddress = sMAC;
			this.ipAddress = sIP;
		}

		public static string GetCurrentExecutionFileName() {
			return System.Web.HttpContext.Current.Request.CurrentExecutionFilePath.Substring(System.Web.HttpContext.Current.Request.CurrentExecutionFilePath.LastIndexOf("/") + 1);
		}

		public string ServerMAC {
			get {
				return this.macAddress;
			}
		}

		public string ServerIP {
			get {
				return this.ipAddress;
			}
		}
	}
}
