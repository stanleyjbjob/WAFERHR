using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.ComponentModel;

[assembly: TagPrefix("WOW.Web.UI.MyControls", "WOW")]
namespace WOW.Web.UI.MyControls
{
    [ToolboxData("<{0}:MyGrid runat=\"server\"> </{0}:MyGrid>")]
    [ParseChildren(true)]
    public class MyGridView : GridView, INamingContainer 
    {
        private bool _mbShowRowCount = false;
        [Browsable(true)]
        [Description("Show the row count label")]
        [DefaultValue(false)]
        [Category("ShowRowCount")]
        [PersistenceMode(PersistenceMode.Attribute)]
        public bool ShowRowCount
        {
            get { return _mbShowRowCount; }
            set { _mbShowRowCount = value; }
        }
      

        protected override void CreateChildControls()
        {
            if (this.ShowRowCount)
            {
                Label lblStuff = new Label();
                lblStuff.Text = "Good-bye cruel woild";
                this.Controls.Add(lblStuff);
            }

           // base.CreateChildControls();
        }
        protected override void PrepareControlHierarchy()
        {
            
            base.PrepareControlHierarchy();
            
        }
    

    }
}



      
