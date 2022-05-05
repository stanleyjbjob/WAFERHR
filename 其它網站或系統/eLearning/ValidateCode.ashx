<%@ WebHandler Language="C#" Class="ValidateCode" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Drawing;
using System.Collections.Generic;

public class ValidateCode : IHttpHandler, IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "image/png";
        this.CreateCheckCodeImage(GenerateCheckCode(context), context);

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    #region 存取驗證碼
    private string CheckCode
    {
        set
        {
            HttpContext context = HttpContext.Current;
            if (context.Session["_ValCheckCode"] == null)
            {
                context.Session.Add("_ValCheckCode", value);
            }
            else
            {
                context.Session["_ValCheckCode"] = value;
            }
        }
        get
        {
            HttpContext context = HttpContext.Current;
            if (context.Session["_ValCheckCode"] == null)
            {
                return "";
            }
            else
            {
                return (string)context.Session["_ValCheckCode"];
            }            
        }
    }
    #endregion

    private int GetRandomCnt()
    {
        Random rd = new Random(DateTime.Now.Millisecond);
        return rd.Next(0, 6);
    }
    
    private string GenerateCheckCode(HttpContext context)
    {
        //設定隨機字元
        string str = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789";
        char[] chastr = str.ToCharArray();
        string code = "";
        Random rd = new Random();
        int i;
        
        //取出字數
        for (i = 0; i < 4; i++)
        {
            code += str.Substring(rd.Next(0, str.Length), 1);
        }
        
        //存入Session中
        this.CheckCode = code;
        
        return code;
    }
    
    private void CreateCheckCodeImage(string checkCode, HttpContext context)
    {
        #region 資源宣告
        string[] oFontName = {"Arial",
                              "Times New Roman", 
                              "MS Mincho", 
                              "Book Antiqua",
                              "Gungsuh", 
                              "PMingLiU", 
                              "Impact"};
        List<Color> oColor = new List<Color>();
        oColor.Add(Color.Black);
        oColor.Add(Color.Red);
        oColor.Add(Color.SteelBlue);
        oColor.Add(Color.Violet);
        oColor.Add(Color.Bisque);
        oColor.Add(Color.BurlyWood);
        oColor.Add(Color.Cyan);
        #endregion
        
        if (checkCode.Trim() == "" || checkCode == null)
            return;
        //設定圖片大小
        Bitmap image = new Bitmap(60, 23);
        
        Graphics g = Graphics.FromImage(image);
        try
        {            
            Random random = new Random();
            g.Clear(Color.White);
            //設定背景噪線
            int i;
            for (i = 0; i < 4; i++)
            {
                int x1 = random.Next(image.Width);
                int x2 = random.Next(image.Width);
                int y1 = random.Next(image.Height);
                int y2 = random.Next(image.Height);
                g.DrawLine(new Pen(oColor[GetRandomCnt()]), x1, y1, x2, y2);
            }
            
            Font font = new System.Drawing.Font(oFontName[GetRandomCnt()], 12, (System.Drawing.FontStyle.Italic));
            System.Drawing.Drawing2D.LinearGradientBrush brush = new System.Drawing.Drawing2D.LinearGradientBrush(new Rectangle(0, 0, image.Width, image.Height), Color.Blue, Color.DarkRed, 1.2F, true);
            g.DrawString(checkCode, font, brush, 2, 2);
            g.DrawRectangle(new Pen(Color.Black), 0, 0, image.Width - 1, image.Height - 1);
            
            //產生噪點
            for (i = 0; i < 40; i++)
            {
                image.SetPixel(random.Next(image.Width), random.Next(image.Height), oColor[GetRandomCnt()]);
            }
            
            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            image.Save(ms, System.Drawing.Imaging.ImageFormat.Gif);
            context.Response.BinaryWrite(ms.ToArray());
        }
        catch
        {
            g.Dispose();
            image.Dispose();
        }
    }
}