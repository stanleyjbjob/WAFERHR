using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.ComponentModel;
using System.Collections;

[assembly: TagPrefix("Safi.UI", "Safi")]
namespace Safi.UI {
    /// <summary>   
    /// An enhanced DropDownList which traps the SelectedValueNotInList exception.   
    /// </summary>   
    /// <remarks>   
    /// When a nested DropDownList is bound to a datasource and to a SelectedValue, and   
    /// the SelectedValue does not appear in the list returned by the datasource, the   
    /// ASP.NET throws an ArgumentOutOfRangeException that the consuming code cannot trap   
    /// and deal with.  None of the available event handlers (apparently) enable this situation   
    /// either to be avoided or caught.   
    /// This Implementation inherits the DropDownList and overrides the offending method, wrapping   
    /// a call to the base method in a try catch block, and handling the error.   
    /// </remarks>   
    /// <seealso cref="http://weblogs.asp.net/hpreishuber/archive/2005/10/11/427266.aspx"/>   
    public class ExtendedDropDownList : System.Web.UI.WebControls.DropDownList {
        #region private fields

        private string cachedSelectedValue;

        #endregion private fields

        #region Constructor

        public ExtendedDropDownList() {
        }

        #endregion Constructor

        #region Properties
        [Themeable(false), DefaultValue("Old Value")]
        public virtual string ObsoleteValueText {
            get {
                object obj2 = this.ViewState["ObsoleteValueText"];
                if (obj2 != null && !string.IsNullOrEmpty(obj2.ToString())) {
                    return (string)obj2;
                }
                return "Item archived";
            }
            set {
                this.ViewState["ObsoleteValueText"] = value;
                //if (base.Initialized)   
                //{   
                //    base.RequiresDataBinding = true;   
                //}   
            }
        }

        public override string SelectedValue {
            get {
                return base.SelectedValue;
            }
            set {
                try {
                    base.SelectedValue = value;
                    // This is the important bit.  The base DropDownList overwrites the SelectedValue property during binding.   
                    // It uses a private cachedSelectedValue variable to track the original value.   
                    // That variable is written to in the SelectedValue setter.   
                    // However the code (in base.PerformDataBinding) that throws the ArgumentOutOfRangeException   
                    // will also write SelectedValue to "0". We only want to get a copy of the "real" SelectedValue.   
                    // This solution is a HACK, but the best I can come up with just now.   
                    if (value != "0")
                        cachedSelectedValue = value;
                }
                catch { }
            }
        }

        #endregion Properties

        #region Handle ArgumentOutOfRangeException

        protected override void PerformDataBinding(System.Collections.IEnumerable dataSource) {
            string selectedValue = this.SelectedValue;
            try {
                base.PerformDataBinding(dataSource);
            }
            catch (ArgumentOutOfRangeException) {
                ListItem item = new ListItem();
                item.Value = cachedSelectedValue;
                item.Text = this.ObsoleteValueText;
                this.Items.Add(item);
                this.SelectedIndex = this.Items.IndexOf(this.Items.FindByValue(cachedSelectedValue));
            }
        }

        #endregion Handle ArgumentOutOfRangeException

    }
}
