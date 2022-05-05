using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
using System.Data.SqlClient;

/// <summary>
/// DataClass 的摘要描述
/// </summary>
public class DataClass
{
    public static SqlConnection GetConnection()
    {
        string sCon = ConfigurationSettings.AppSettings["syanghr"];
        SqlConnection con = new SqlConnection(sCon);
        return con;
    }
    public static EFFDS.EFFS_BASERow getEff_Base_Num(string nobr, string yy, string seq)
    {
        EFFDSTableAdapters.EFFS_BASETableAdapter bad = new EFFDSTableAdapters.EFFS_BASETableAdapter();
        EFFDS.EFFS_BASEDataTable bdt = bad.GetDataBySelectNobr(yy, seq, nobr);
        return bdt[0];

    }


    public static void setEff_Base_Num(string nobr, string yy, string seq, decimal num, string eff)
    {
        EFFDSTableAdapters.EFFS_BASETableAdapter bad = new EFFDSTableAdapters.EFFS_BASETableAdapter();
        EFFDS.EFFS_BASEDataTable bdt = bad.GetDataBySelectNobr(yy, seq, nobr);
        if (bdt.Rows.Count > 0)
        {
            bdt[0].effsfinally = eff;
            bdt[0].depts = num.ToString();
            bad.Update(bdt);

        }

    }
    public static void setEff_Base_Num(string nobr, string yy, string seq, decimal num)
    {
        EFFDSTableAdapters.EFFS_BASETableAdapter bad = new EFFDSTableAdapters.EFFS_BASETableAdapter();
        EFFDS.EFFS_BASEDataTable bdt = bad.GetDataBySelectNobr(yy, seq, nobr);
        if (bdt.Rows.Count > 0)
        {
            //  bdt[0].effsfinally = eff;
            bdt[0].depts = num.ToString();
            bad.Update(bdt);

        }

    }
    public static void setEff_Base_Num(string nobr, string yy, string seq, string eff)
    {
        EFFDSTableAdapters.EFFS_BASETableAdapter bad = new EFFDSTableAdapters.EFFS_BASETableAdapter();
        EFFDS.EFFS_BASEDataTable bdt = bad.GetDataBySelectNobr(yy, seq, nobr);
        if (bdt.Rows.Count > 0)
        {
            bdt[0].effsfinally = eff;
            //  bdt[0].jobplan = num.ToString();
            bad.Update(bdt);

        }

    }

    public static void setEff_Base_jobPlan(string nobr, string yy, string seq, string plan)
    {
        EFFDSTableAdapters.EFFS_BASETableAdapter bad = new EFFDSTableAdapters.EFFS_BASETableAdapter();
        EFFDS.EFFS_BASEDataTable bdt = bad.GetDataBySelectNobr(yy, seq, nobr);
        if (bdt.Rows.Count > 0)
        {
            bdt[0].jobplan = plan;
            //  bdt[0].jobplan = num.ToString();
            bad.Update(bdt);

        }

    }






    public static EFFDS.EFFS_GROUPRow getEffGroup(string id)
    {
        EFFDSTableAdapters.EFFS_GROUPTableAdapter ad = new EFFDSTableAdapters.EFFS_GROUPTableAdapter();
        EFFDS.EFFS_GROUPDataTable dt = ad.GetDataByID(id);
        return dt[0];

    }
    public static DataTable getTempletCateType(int yy, int seq, string nobr, string templetID, bool included)
    {
        DataTable ds = new DataTable();

        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {
            con = DataClass.GetConnection();
            cmd = new SqlCommand();
            cmd.Connection = con;

            string sSelect =
               string.Format(@"SELECT     EFFS_TYPE.type, EFFS_TYPE.typeName as 評估種類
FROM         EFFS_TEMPLETTYPE INNER JOIN
                      EFFS_TYPE ON EFFS_TEMPLETTYPE.type = EFFS_TYPE.type
WHERE     (EFFS_TEMPLETTYPE.templetID = '{0}')
ORDER BY EFFS_TEMPLETTYPE.[order]", templetID);


            // concat to the select statement
            cmd.CommandText = sSelect;

            // execute the query
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd != null) cmd.Dispose();
            if (con != null) con.Dispose();
        }

        return ds;

    }

    public static DataTable getMangType(int yy, int seq, string nobr, string templetID, bool included,string mangNobr)
    {
        DataTable ds = new DataTable();

        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {
            con = DataClass.GetConnection();
            cmd = new SqlCommand();
            cmd.Connection = con;

            string sSelect =
               string.Format(@"SELECT     EFFS_TYPE.type, EFFS_TYPE.typeName as 評估種類
FROM         EFFS_TEMPLETTYPE INNER JOIN
                      EFFS_TYPE ON EFFS_TEMPLETTYPE.type = EFFS_TYPE.type
WHERE     (EFFS_TEMPLETTYPE.templetID = '{0}')
ORDER BY EFFS_TEMPLETTYPE.[order]", templetID);


            // concat to the select statement
            cmd.CommandText = sSelect;

            // execute the query
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd != null) cmd.Dispose();
            if (con != null) con.Dispose();
        }


        EFFMANGDS.EFFS_MANGNUMRow selfapprrow = null;
        EFFMANGDS.EFFS_MANGNUMRow selfcaterow = null;


        ds.Columns.Add("評分");
        //ds.Columns.Add("權重");


        //ds.Columns.Add("加權分數");
        // ds.Columns.Add("總評分");
        EFFMANGDS.EFFS_MANGRATERow raterow = getEFFMANGRATE(yy, seq, nobr);


        for (int i = 0; i < ds.Rows.Count; i++)
        {
            //  ds.Rows[i]["總評分"] = "0";
            if (ds.Rows[i]["type"].ToString().Trim().Equals("A001"))
            {
                selfapprrow = getEffsMangApprNum(yy, seq, included, nobr, templetID, "A001",mangNobr);

                if (selfapprrow != null && !selfapprrow.IsmangapprnumNull())
                {
                    ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfapprrow.mangapprnum, 3, MidpointRounding.AwayFromZero));
                }
                else
                {
                    ds.Rows[i]["評分"] = "0";
                }
                // ds.Rows[i]["appr_name"] = selfcaterow.name;
                //   ds.Rows[i]["權重"] = Convert.ToString(Math.Round(selfapprrow.rate, 1, MidpointRounding.AwayFromZero)) + "%";
                //  ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfapprrow.ratenum, 1, MidpointRounding.AwayFromZero));
                if (raterow != null)
                {
                    //   ds.Rows[i]["權重"] = Convert.ToString(Math.Round(raterow.arrprate, 1, MidpointRounding.AwayFromZero)) + "%"; //raterow.arrprate;
                    //    ds.Rows[i]["加權分數"] = Math.Round(selfapprrow.apprnum * raterow.arrprate / 100, 1, MidpointRounding.AwayFromZero);
                }
                //     ds.Rows[i]["總評分"] = ds.Rows[i]["評分"];

            }
            else if (ds.Rows[i]["type"].ToString().Trim().Equals("B001"))
            {
                selfcaterow = getEffsMangCateNum(templetID,yy, seq, nobr, "B001",mangNobr);
                if (selfcaterow != null && !selfcaterow.IsmangapprnumNull())
                {
                    if (templetID.Trim().Equals("FY9B"))
                    {
                        ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfcaterow.mangapprnum / 30, 3, MidpointRounding.ToEven));
                    }
                    else
                    {
                        ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfcaterow.mangapprnum / 20, 3, MidpointRounding.ToEven));
                    }

                }
                else
                {
                    ds.Rows[i]["評分"] = "0";
                }
                // ds.Rows[i]["appr_name"] = selfcaterow.name;
                // ds.Rows[i]["權重"] = Convert.ToString(Math.Round(selfcaterow.rate, 1, MidpointRounding.AwayFromZero)) + "%";
                // ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfcaterow.ratenum, 1, MidpointRounding.AwayFromZero));
                if (raterow != null)
                {
                    //   ds.Rows[i]["權重"] = Convert.ToString(Math.Round(raterow.caterate, 1, MidpointRounding.AwayFromZero)) + "%"; //raterow.arrprate;
                    // ds.Rows[i]["加權分數"] = Math.Round(selfcaterow.apprnum * raterow.caterate / 100, 1, MidpointRounding.AwayFromZero);
                }
                //     ds.Rows[i]["總評分"] =Convert.ToString( double.Parse( ds.Rows[i]["評分"].ToString())+double.Parse( ds.Rows[i]["總評分"].ToString));
            }

        }


        // return the dataset
        return ds;
    }
    public static DataTable getMangType(int yy, int seq, string nobr, string templetID, bool included, string mang, string typeID)
    {
        DataTable ds = new DataTable();

        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {
            con = DataClass.GetConnection();
            cmd = new SqlCommand();
            cmd.Connection = con;

            string sSelect =
               string.Format(@"SELECT     EFFS_TYPE.type, EFFS_TYPE.typeName as 評估種類
FROM         EFFS_TEMPLETTYPE INNER JOIN
                      EFFS_TYPE ON EFFS_TEMPLETTYPE.type = EFFS_TYPE.type
WHERE     (EFFS_TEMPLETTYPE.templetID = '{0}' ) and EFFS_TYPE.type ='{1}' 
ORDER BY EFFS_TEMPLETTYPE.[order]", templetID, typeID);


            // concat to the select statement
            cmd.CommandText = sSelect;

            // execute the query
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd != null) cmd.Dispose();
            if (con != null) con.Dispose();
        }



        EFFMANGDS.EFFS_MANGNUMRow selfapprrow = null;
        EFFMANGDS.EFFS_MANGNUMRow selfcaterow = null;



        ds.Columns.Add("評分");
        ds.Columns.Add("權重");


        ds.Columns.Add("加權分數");
        ds.Columns.Add("評核者");
        EFFMANGDS.EFFS_MANGRATERow raterow = getEFFMANGRATE(yy, seq, nobr);


        for (int i = 0; i < ds.Rows.Count; i++)
        {
            try
            {
                if (ds.Rows[i]["type"].ToString().Trim().Equals("A001"))
                {
                    selfapprrow = getEffsMangApprNum(yy, seq, included, nobr, templetID, "A001", mang);

                    if (selfapprrow == null)
                        continue;

                    if (templetID.Trim().Equals("FY9B"))
                    {
                        ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfapprrow.mangapprnum, 3, MidpointRounding.ToEven));
                    }
                    else
                    {
                        ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfapprrow.mangapprnum, 3, MidpointRounding.ToEven));
                    }
                  //  ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfapprrow.mangapprnum, 1, MidpointRounding.AwayFromZero));
                    
                    // ds.Rows[i]["appr_name"] = selfcaterow.name;
                    ds.Rows[i]["權重"] = Convert.ToString(Math.Round(selfapprrow.rate, 1, MidpointRounding.AwayFromZero)) + "%";

                    if (templetID.Trim().Equals("FY9B"))
                    {
                        ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfapprrow.mangapprnum , 3, MidpointRounding.ToEven));
                    }
                    else
                    {
                        ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfapprrow.mangapprnum, 3, MidpointRounding.ToEven));
                    }
                 //   ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfapprrow.ratenum, 1, MidpointRounding.AwayFromZero));
                    ds.Rows[i]["評核者"] = selfapprrow.mangname;
                    if (raterow != null)
                    {
                        ds.Rows[i]["權重"] = Convert.ToString(Math.Round(raterow.arrprate, 1, MidpointRounding.AwayFromZero)) + "%"; //raterow.arrprate;
                        ds.Rows[i]["加權分數"] = Math.Round(selfapprrow.mangapprnum * raterow.arrprate / 100, 1, MidpointRounding.AwayFromZero);
                    }

                }
                else if (ds.Rows[i]["type"].ToString().Trim().Equals("B001"))
                {
                    selfcaterow = getEffsMangCateNum(templetID, yy, seq, nobr, "B001", mang);

                    if (templetID.Trim().Equals("FY9B"))
                    {
                        ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfcaterow.mangapprnum / 30, 3, MidpointRounding.ToEven));
                    }
                    else
                    {
                        ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfcaterow.mangapprnum / 20, 3, MidpointRounding.ToEven));
                    }
                  //  ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfcaterow.mangapprnum, 1, MidpointRounding.AwayFromZero));
                    // ds.Rows[i]["appr_name"] = selfcaterow.name;
                    ds.Rows[i]["權重"] = Convert.ToString(Math.Round(selfcaterow.rate, 1, MidpointRounding.AwayFromZero)) + "%";
                    if (templetID.Trim().Equals("FY9B"))
                    {
                        ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfcaterow.mangapprnum / 30, 3, MidpointRounding.ToEven));
                    }
                    else
                    {
                        ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfcaterow.mangapprnum / 20, 3, MidpointRounding.ToEven));
                    }
                 //   ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfcaterow.ratenum, 1, MidpointRounding.AwayFromZero));
                    ds.Rows[i]["評核者"] = selfcaterow.mangname;
                    if (raterow != null)
                    {
                        ds.Rows[i]["權重"] = Convert.ToString(Math.Round(raterow.caterate, 1, MidpointRounding.AwayFromZero)) + "%"; //raterow.arrprate;
                        ds.Rows[i]["加權分數"] = Math.Round(selfcaterow.mangapprnum * raterow.caterate / 100, 1, MidpointRounding.AwayFromZero);
                    }
                }
            }
            catch { }

        }


        // return the dataset
        return ds;
    }





    public static DataTable getSelfType(int yy, int seq, string nobr, string templetID, bool included)
    {
        DataTable ds = new DataTable();

        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {
            con = DataClass.GetConnection();
            cmd = new SqlCommand();
            cmd.Connection = con;

            string sSelect =
               string.Format(@"SELECT     EFFS_TYPE.type, EFFS_TYPE.typeName as 評估種類
FROM         EFFS_TEMPLETTYPE INNER JOIN
                      EFFS_TYPE ON EFFS_TEMPLETTYPE.type = EFFS_TYPE.type
WHERE     (EFFS_TEMPLETTYPE.templetID = '{0}')
ORDER BY EFFS_TEMPLETTYPE.[order]", templetID);


            // concat to the select statement
            cmd.CommandText = sSelect;

            // execute the query
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd != null) cmd.Dispose();
            if (con != null) con.Dispose();
        }


        EFFMANGDS.EFFS_SELFNUMRow selfapprrow = null;
        EFFMANGDS.EFFS_SELFNUMRow selfcaterow = null;

        
        ds.Columns.Add("評分");
        //ds.Columns.Add("權重");


        //ds.Columns.Add("加權分數");
       // ds.Columns.Add("總評分");
        EFFMANGDS.EFFS_MANGRATERow raterow = getEFFMANGRATE(yy, seq, nobr);

      
        for (int i = 0; i < ds.Rows.Count; i++)
        {
          //  ds.Rows[i]["總評分"] = "0";
            if (ds.Rows[i]["type"].ToString().Trim().Equals("A001"))
            {
                selfapprrow = getEffsSelfApprNum(yy, seq, included, nobr, templetID, "A001");

                if (selfapprrow !=null && !selfapprrow.IsapprnumNull())
                {
                    ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfapprrow.apprnum, 3, MidpointRounding.AwayFromZero));
                }
                else {
                    ds.Rows[i]["評分"] = "0";
                }
                // ds.Rows[i]["appr_name"] = selfcaterow.name;
             //   ds.Rows[i]["權重"] = Convert.ToString(Math.Round(selfapprrow.rate, 1, MidpointRounding.AwayFromZero)) + "%";
              //  ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfapprrow.ratenum, 1, MidpointRounding.AwayFromZero));
                if (raterow != null)
                {
                 //   ds.Rows[i]["權重"] = Convert.ToString(Math.Round(raterow.arrprate, 1, MidpointRounding.AwayFromZero)) + "%"; //raterow.arrprate;
                //    ds.Rows[i]["加權分數"] = Math.Round(selfapprrow.apprnum * raterow.arrprate / 100, 1, MidpointRounding.AwayFromZero);
                }
           //     ds.Rows[i]["總評分"] = ds.Rows[i]["評分"];

            }
            else if (ds.Rows[i]["type"].ToString().Trim().Equals("B001"))
            {
                selfcaterow = getEffsSelfCateNum(yy, seq, nobr, "B001", templetID);
                if (selfcaterow != null && !selfcaterow.IsapprnumNull())
                {
                    if (templetID.Trim().Equals("FY9B"))
                    {
                        ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfcaterow.apprnum / 30, 3, MidpointRounding.ToEven));
                    }
                    else
                    {
                        ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfcaterow.apprnum / 20, 3, MidpointRounding.ToEven));
                    }
                }
                else {
                    ds.Rows[i]["評分"] = "0";
                }
                // ds.Rows[i]["appr_name"] = selfcaterow.name;
               // ds.Rows[i]["權重"] = Convert.ToString(Math.Round(selfcaterow.rate, 1, MidpointRounding.AwayFromZero)) + "%";
               // ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfcaterow.ratenum, 1, MidpointRounding.AwayFromZero));
                if (raterow != null)
                {
                 //   ds.Rows[i]["權重"] = Convert.ToString(Math.Round(raterow.caterate, 1, MidpointRounding.AwayFromZero)) + "%"; //raterow.arrprate;
                   // ds.Rows[i]["加權分數"] = Math.Round(selfcaterow.apprnum * raterow.caterate / 100, 1, MidpointRounding.AwayFromZero);
                }
           //     ds.Rows[i]["總評分"] =Convert.ToString( double.Parse( ds.Rows[i]["評分"].ToString())+double.Parse( ds.Rows[i]["總評分"].ToString));
            }

        }


        // return the dataset
        return ds;
    }

    public static DataTable getSelfType(int yy, int seq, string nobr, string templetID, bool included, string type)
    {
        DataTable ds = new DataTable();

        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {
            con = DataClass.GetConnection();
            cmd = new SqlCommand();
            cmd.Connection = con;

            string sSelect =
               string.Format(@"SELECT     EFFS_TYPE.type, EFFS_TYPE.typeName as 評估種類
FROM         EFFS_TEMPLETTYPE INNER JOIN
                      EFFS_TYPE ON EFFS_TEMPLETTYPE.type = EFFS_TYPE.type
WHERE     (EFFS_TEMPLETTYPE.templetID = '{0}') and EFFS_TYPE.type ='{1}'
ORDER BY EFFS_TEMPLETTYPE.[order]", templetID, type);


            // concat to the select statement
            cmd.CommandText = sSelect;

            // execute the query
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd != null) cmd.Dispose();
            if (con != null) con.Dispose();
        }


        EFFMANGDS.EFFS_SELFNUMRow selfapprrow = null;
        EFFMANGDS.EFFS_SELFNUMRow selfcaterow = null;


        ds.Columns.Add("評分");
        ds.Columns.Add("權重");


        ds.Columns.Add("加權分數");
        EFFMANGDS.EFFS_MANGRATERow raterow = getEFFMANGRATE(yy, seq, nobr);


        for (int i = 0; i < ds.Rows.Count; i++)
        {
            try
            {
                if (ds.Rows[i]["type"].ToString().Trim().Equals("A001"))
                {
                    selfapprrow = getEffsSelfApprNum(yy, seq, included, nobr, templetID, "A001");


                    ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfapprrow.apprnum, 1, MidpointRounding.AwayFromZero));
                    // ds.Rows[i]["appr_name"] = selfcaterow.name;
                    ds.Rows[i]["權重"] = Convert.ToString(Math.Round(selfapprrow.rate, 1, MidpointRounding.AwayFromZero)) + "%";
                    if (templetID.Trim().Equals("FY9B"))
                    {
                        ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfapprrow.apprnum, 3, MidpointRounding.ToEven));
                    }
                    else
                    {
                        ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfapprrow.apprnum , 3, MidpointRounding.ToEven));
                    }
                   // ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfapprrow.ratenum, 1, MidpointRounding.AwayFromZero));
                    if (raterow != null)
                    {
                        ds.Rows[i]["權重"] = Convert.ToString(Math.Round(raterow.arrprate, 1, MidpointRounding.AwayFromZero)) + "%"; //raterow.arrprate;
                        ds.Rows[i]["加權分數"] = Math.Round(selfapprrow.apprnum * raterow.arrprate / 100, 1, MidpointRounding.AwayFromZero);
                    }

                }
                else if (ds.Rows[i]["type"].ToString().Trim().Equals("B001"))
                {
                    selfcaterow = getEffsSelfCateNum(yy, seq, nobr, "B001", templetID);
                    ds.Rows[i]["評分"] = Convert.ToString(Math.Round(selfcaterow.apprnum, 1, MidpointRounding.AwayFromZero));
                    // ds.Rows[i]["appr_name"] = selfcaterow.name;
                    ds.Rows[i]["權重"] = Convert.ToString(Math.Round(selfcaterow.rate, 1, MidpointRounding.AwayFromZero)) + "%";
                    if (templetID.Trim().Equals("FY9B"))
                    {
                        ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfcaterow.apprnum / 30, 3, MidpointRounding.ToEven));
                    }
                    else
                    {
                        ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfcaterow.apprnum / 20, 3, MidpointRounding.ToEven));
                    }

                    //ds.Rows[i]["加權分數"] = Convert.ToString(Math.Round(selfcaterow.ratenum, 1, MidpointRounding.AwayFromZero));
                    if (raterow != null)
                    {
                        ds.Rows[i]["權重"] = Convert.ToString(Math.Round(raterow.caterate, 1, MidpointRounding.AwayFromZero)) + "%"; //raterow.arrprate;
                        ds.Rows[i]["加權分數"] = Math.Round(selfcaterow.apprnum * raterow.caterate / 100, 1, MidpointRounding.AwayFromZero);
                    }
                }
            }
            catch { }

        }


        // return the dataset
        return ds;
    }

    public static bool getIsSendEffs(int yy, int seq, string nobr, string mangNobr) 
    {
        bool isok = false;
          EFFMANGDSTableAdapters.EFFS_MANGAPPENDTableAdapter appad = new EFFMANGDSTableAdapters.EFFS_MANGAPPENDTableAdapter();
        EFFMANGDS.EFFS_MANGAPPENDDataTable appdt = appad.GetDataByMangNobr(yy,seq,nobr,mangNobr);
        if (appdt.Rows.Count > 0)
        {
            isok = true;
        }
        return isok;
    
    }
    public static string getSendEffsTime(int yy, int seq, string nobr, string mangNobr)
    {
        string time = "未傳送！！";
        EFFMANGDSTableAdapters.EFFS_MANGAPPENDTableAdapter appad = new EFFMANGDSTableAdapters.EFFS_MANGAPPENDTableAdapter();
        EFFMANGDS.EFFS_MANGAPPENDDataTable appdt = appad.GetDataByMangNobr(yy, seq, nobr, mangNobr);
        if (appdt.Rows.Count > 0)
        {
            time = appdt[0].appstddate.ToString() ;
        }
        return time;

    }

    public static string getMangFinishNote(int yy,int seq ,string nobr) {
        EFFMANGDSTableAdapters.EFFS_MANGFINISHNOTETableAdapter notead = new EFFMANGDSTableAdapters.EFFS_MANGFINISHNOTETableAdapter();
        EFFMANGDS.EFFS_MANGFINISHNOTEDataTable notedt = notead.GetData(yy, seq, nobr);
        string note = "";
        if (notedt.Rows.Count > 0) 
        {
            if (!notedt[0].IsnoteNull())
                note = notedt[0].note;
        }
        return note;
    }
    public static DataTable getabs(string nobr, string adate, string ddate)
    {
        DataTable ds = new DataTable();

        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {
            con = DataClass.GetConnection();
            cmd = new SqlCommand();
            cmd.Connection = con;

            string sSelect =
                "SELECT         Nobr, bdate, h_code, tol_hours, tol_day " +
 " FROM            abs " +
 " WHERE         (Nobr = '" + nobr + "')  AND (bdate BETWEEN '" + adate + "' AND " +
 "                         '" + ddate + "') ";




            // concat to the select statement
            cmd.CommandText = sSelect;

            // execute the query
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd != null) cmd.Dispose();
            if (con != null) con.Dispose();
        }

        // return the dataset
        return ds;
    }


    public static DataTable getaward(string nobr, string adate, string ddate)
    {
        DataTable ds = new DataTable();

        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {
            con = DataClass.GetConnection();
            cmd = new SqlCommand();
            cmd.Connection = con;

            string sSelect =
                "SELECT  award.note, award.adate, awardcd.descr, award.award1, award.award2, award.award3, award.award4, award.award5, award.fault1, award.fault2, award.fault3 FROM award INNER JOIN awardcd ON award.award_code = awardcd.award_code WHERE (award.Nobr ='" + nobr + "') and award.adate between '" + adate + "' and '" + ddate + "'  ORDER BY award.adate DESC";

            // concat to the select statement
            cmd.CommandText = sSelect;

            // execute the query
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(ds);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            if (cmd != null) cmd.Dispose();
            if (con != null) con.Dispose();
        }

        // return the dataset
        return ds;
    }




	public DataClass()
	{
		//
		// TODO: 在此加入建構函式的程式碼
		//
	}

    static public bool IsAdmin(string nobr ) {
        bool isok = false;
        EFF_EXDSTableAdapters.EFFS_AdminTableAdapter adminad = new EFF_EXDSTableAdapters.EFFS_AdminTableAdapter();
        object o = adminad.ScalarQuery_AdminCount(nobr);
        try {
            int count = int.Parse(o.ToString());
            if(count >0)
                isok = true;
        }
        catch {
            return isok;
        }

        return isok;
    }

    static public EFF_EXDS.EFFS_FunRow getEffs_FunRow(string templetID) {
        EFF_EXDSTableAdapters.EFFS_FunTableAdapter funad = new EFF_EXDSTableAdapters.EFFS_FunTableAdapter();
        EFF_EXDS.EFFS_FunDataTable fundt = funad.GetDataBy(templetID);
        if (fundt.Rows.Count <= 0)
            return null;

        return fundt[0];
    }

    static public bool checkApprTts(int ID)
    {
        bool isok = false;
        EFFMANGDSTableAdapters.EFFS_APPRTTSTableAdapter ttsad = new EFFMANGDSTableAdapters.EFFS_APPRTTSTableAdapter();
        EFFMANGDS.EFFS_APPRTTSDataTable ttsdt = ttsad.GetDataByIDNOTTYPE(ID);
        if (ttsdt.Rows.Count > 0) {
            isok = true;
        }
        return isok;
    }

    static public bool ISMANG(string nobr,string adate)
    {
        bool isok = false;
        EFFDSTableAdapters.EMPINFOTableAdapter ttsad = new EFFDSTableAdapters.EMPINFOTableAdapter();
        EFFDS.EMPINFODataTableDataTable empdt = ttsad.GetDataByNobr(nobr,DateTime.Parse( adate));
        if (empdt.Rows.Count > 0)
        {
            isok = empdt[0].MANG;
        }
        return isok;
    }
    static public EFFDS.EFFS_APPRRow getEFFS_APPRRow(int ID) 
    {
        EFFDSTableAdapters.EFFS_APPRTableAdapter apprad = new EFFDSTableAdapters.EFFS_APPRTableAdapter();
        EFFDS.EFFS_APPRDataTable apprdt = apprad.GetDataByID(ID);
        EFFDS.EFFS_APPRRow row = null;
        if (apprdt.Rows.Count > 0) 
        {
            row = (EFFDS.EFFS_APPRRow)apprdt.Rows[0];
        }
        return row;
    }



    static public EFFDS.EFFS_SELFLEARNPLANRow getSELFLEARNPLANRow(string yy,string seq ,string nobr,string learnplanid)
    {

        EFFDSTableAdapters.EFFS_SELFLEARNPLANTableAdapter planad = new EFFDSTableAdapters.EFFS_SELFLEARNPLANTableAdapter();
        EFFDS.EFFS_SELFLEARNPLANDataTable plandt = planad.GetData(int.Parse(yy), int.Parse(seq), nobr, learnplanid);
        EFFDS.EFFS_SELFLEARNPLANRow row = null;
        if (plandt.Rows.Count > 0)
        {
            row = (EFFDS.EFFS_SELFLEARNPLANRow)plandt.Rows[0];
        }

        return row;
    }

    static public HRDS.DeptAMangDataTableDataTable getempMang(string dept,bool ismang,string  adate) 
    {
        HRDSTableAdapters.DeptAMangTableAdapter deptad = new HRDSTableAdapters.DeptAMangTableAdapter();
        string _dept = dept;
        HRDS.DeptAMangDataTableDataTable r_deptdt = new HRDS.DeptAMangDataTableDataTable();
        bool isok = true;
        if (ismang) {
            HRDS.DeptAMangDataTableDataTable deptdtmang = deptad.GetDataByDept(DateTime.Parse( adate),_dept);
            if (deptdtmang.Rows.Count > 0)
            {
              _dept =  deptdtmang[0].dept_group;
            }
        }

        int indexcount = 0;
        do
        {
            indexcount++;
            HRDS.DeptAMangDataTableDataTable deptdt = deptad.GetDataByDept( DateTime.Parse( adate),_dept);
            if (deptdt.Rows.Count > 0)
            {
                
                HRDS.DeptAMangDataTableRow deptrow = (HRDS.DeptAMangDataTableRow)deptdt.Rows[0];
                if (deptrow.cate_order <= 70)
                {
                    if (!deptrow.IsNAME_CNull())
                    {
                        r_deptdt.Merge(deptdt);
                    }
                    _dept = deptrow.dept_group;
                   
                }
                else {
                    isok = false;
                }
            }
            else
            {
                isok = false;
            }

            if (indexcount >= 10) 
            {
                isok = false;
            }
        } while (isok);



        return r_deptdt;
    }

    static public int getDeptMangOrder(string dept,string adate) {
        int order = 0;
        HRDSTableAdapters.DeptAMangTableAdapter deptad = new HRDSTableAdapters.DeptAMangTableAdapter();
        HRDS.DeptAMangDataTableDataTable deptdt = deptad.GetDataByDept(DateTime.Parse( adate),dept);
        if (deptdt.Rows.Count > 0) {
            HRDS.DeptAMangDataTableRow row = (HRDS.DeptAMangDataTableRow)deptdt.Rows[0];
            order = row.cate_order;
        
        }

        return order;
    }

    static public EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable getAPPRMANGGROUP(int yy, int seq, string nobr) 
    {
        EFFMANGDSTableAdapters.EFFS_APPRENDMANGGROUPTableAdapter groupad = new EFFMANGDSTableAdapters.EFFS_APPRENDMANGGROUPTableAdapter();
        EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable groupdt = groupad.GetDataByApprMang(yy, seq, nobr);
        if (groupdt.Rows.Count == 0) {
            groupdt = groupad.GetDataByCateMang(yy, seq, nobr);
        }

        return groupdt;
    
    }
    static public EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable getCATEMANGGROUP(int yy, int seq, string nobr)
    {
        EFFMANGDSTableAdapters.EFFS_APPRENDMANGGROUPTableAdapter groupad = new EFFMANGDSTableAdapters.EFFS_APPRENDMANGGROUPTableAdapter();
        EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable groupdt = groupad.GetDataByCateMang(yy, seq, nobr);
        return groupdt;

    }

    static public EFFMANGDS.EFFS_MANGRATERow getEFFMANGRATE(int yy, int seq,string nobr) 
    {
        EFFMANGDSTableAdapters.EFFS_MANGRATETableAdapter ratead = new EFFMANGDSTableAdapters.EFFS_MANGRATETableAdapter();
        EFFMANGDS.EFFS_MANGRATEDataTable ratedt = ratead.GetDataByNobr(yy, seq, nobr);
        EFFMANGDS.EFFS_MANGRATERow raterow = null;
        if (ratedt.Rows.Count >0) 
        {
            raterow = (EFFMANGDS.EFFS_MANGRATERow)ratedt.Rows[0];
        }
        return raterow;
    }

    static public EFFMANGDS.EFFS_NUMDataTable getEFFMANGSHOWNUM(int yy, int seq, bool included, string nobr, string templet, string apprtype, string catetype, string numID, string mangnobr) 
    {
        EFFMANGDS.EFFS_NUMDataTable numdt = new EFFMANGDS.EFFS_NUMDataTable();
        EFFMANGDS.EFFS_NUMRow row = DataClass.getEFFSELENUM(yy, seq, included, nobr, templet,apprtype,catetype,numID);
        EFFMANGDS.EFFS_NUMRow mangrow = DataClass.getEFFSELENUM(yy, seq, included, nobr, templet, apprtype, catetype, numID,mangnobr);
        numdt.AddEFFS_NUMRow(mangrow.nobr, mangrow.catenum, mangrow.apprnum, mangrow.caterate, mangrow.apprrate, mangrow.cateratenum, mangrow.apprratenum, mangrow.totnum, mangrow.effs, mangrow.mangnobr, mangrow.yy, mangrow.seq, mangrow.name, mangrow.name,mangrow.ratet);
        numdt.AddEFFS_NUMRow(row.nobr, row.catenum, row.apprnum, row.caterate, row.apprrate, row.cateratenum, row.apprratenum, row.totnum, row.effs, row.mangnobr, row.yy, row.seq, row.name, row.mangname, 0);
        return numdt;
    }
    static public EFFMANGDS.EFFS_NUMDataTable getEFFMANGSHOWNUM(int yy, int seq, bool included, string nobr, string templet, string apprtype, string catetype, string numID, ArrayList mangnobrs)
    {
        EFFMANGDS.EFFS_NUMDataTable numdt = new EFFMANGDS.EFFS_NUMDataTable();
        EFFMANGDS.EFFS_NUMRow row = DataClass.getEFFSELENUM(yy, seq, included, nobr, templet, apprtype, catetype, numID);

        for (int i = 0; i < mangnobrs.Count; i++)
        {
            EFFMANGDS.EFFS_NUMRow mangrow = DataClass.getEFFSELENUM(yy, seq, included, nobr, templet, apprtype, catetype, numID, mangnobrs[i].ToString());
            if ((int)mangrow.ratet != 100) {
                continue;
            } 

            numdt.AddEFFS_NUMRow(mangrow.nobr, mangrow.catenum, mangrow.apprnum, mangrow.caterate, mangrow.apprrate, mangrow.cateratenum, mangrow.apprratenum, mangrow.totnum, mangrow.effs, mangrow.mangnobr, mangrow.yy, mangrow.seq, mangrow.name, mangrow.name,mangrow.ratet);
        }
        numdt.AddEFFS_NUMRow(row.nobr, row.catenum, row.apprnum, row.caterate, row.apprrate, row.cateratenum, row.apprratenum, row.totnum, row.effs, row.mangnobr, row.yy, row.seq, row.name, row.mangname, 0);
        
        return numdt;
    }
    static public EFFMANGDS.EFFS_NUMDataTable getEFFMANGSHOWNUM(int yy, int seq, bool included, string nobr, string templet, string apprtype, string catetype, string numID)
    {
        EFFMANGDS.EFFS_NUMDataTable numdt = new EFFMANGDS.EFFS_NUMDataTable();
        EFFMANGDS.EFFS_NUMRow row = DataClass.getEFFSELENUM(yy, seq, included, nobr, templet, apprtype, catetype, numID);
        numdt.AddEFFS_NUMRow(row.nobr, row.catenum, row.apprnum, row.caterate, row.apprrate, row.cateratenum, row.apprratenum, row.totnum, row.effs, row.mangnobr, row.yy, row.seq, row.name, row.mangname,0);
        return numdt;
    }
    


    static public EFFMANGDS.EFFS_NUMRow getEFFSELENUM(int yy, int seq, bool included, string nobr, string templet, string apprtype ,string catetype,string numID)
    {
        EFFMANGDS.EFFS_SELFNUMRow selfapprrow = null;
        EFFMANGDS.EFFS_SELFNUMRow selfcaterow = null;
        selfapprrow = getEffsSelfApprNum(yy, seq, included, nobr, templet, apprtype);
        selfcaterow = getEffsSelfCateNum(yy, seq, nobr, catetype, templet);
        EFFMANGDS.EFFS_NUMDataTable numdt = new EFFMANGDS.EFFS_NUMDataTable();
        EFFMANGDS.EFFS_NUMRow numrow = numdt.NewEFFS_NUMRow();
        EFFMANGDS.EFFS_MANGRATERow raterow = getEFFMANGRATE(yy, seq, nobr);

        numrow.nobr = nobr;
        numrow.yy = yy;
        numrow.seq = seq;
        numrow.mangnobr = "";
        numrow.mangname = "";
        numrow.ratet = 0;
        if (selfapprrow != null)
        {
            numrow.apprnum = selfapprrow.apprnum;
            if (raterow != null)
            {
                numrow.apprrate = raterow.arrprate;
                numrow.apprratenum = Math.Round( numrow.apprnum * raterow.arrprate/100, 1, MidpointRounding.AwayFromZero);
            }
            else
            {
                numrow.apprrate = selfapprrow.rate;
                numrow.apprratenum = selfapprrow.ratenum;
            }
            numrow.name = selfapprrow.name;
        }
        else
        {
            numrow.apprnum = 0;
            numrow.apprrate = 0;
            numrow.apprratenum = 0;
            numrow.name = "";
        }
        if (selfcaterow != null)
        {
            numrow.catenum = selfcaterow.apprnum;
            if (raterow != null)
            {
                numrow.caterate = raterow.caterate;
                numrow.cateratenum = Math.Round(numrow.catenum * raterow.caterate/100, 1, MidpointRounding.AwayFromZero);
            }
            else
            {

                numrow.caterate = selfcaterow.rate;
                numrow.cateratenum = selfcaterow.ratenum;
            }
            numrow.name = selfcaterow.name;
        }
        else
        {
            numrow.catenum = 0;
            numrow.caterate = 0;
            numrow.cateratenum = 0;
            numrow.name = "";
        }
        numrow.totnum = numrow.cateratenum + numrow.apprratenum;
        numrow.effs = getEffsTitle(numrow.totnum, numID);
 　     return numrow;
    }

    static public EFFMANGDS.EFFS_NUMRow getEFFSELENUM(int yy, int seq, bool included, string nobr, string templet, string apprtype, string catetype, string numID ,string mangnobr)
    {
        EFFMANGDS.EFFS_MANGNUMRow selfapprrow = null;
        EFFMANGDS.EFFS_MANGNUMRow selfcaterow = null;
        selfapprrow = getEffsMangApprNum(yy, seq, included, nobr, templet, apprtype,mangnobr);
        selfcaterow = getEffsMangCateNum(templet,yy, seq, nobr, catetype,mangnobr);
        EFFMANGDS.EFFS_NUMDataTable numdt = new EFFMANGDS.EFFS_NUMDataTable();
        EFFMANGDS.EFFS_NUMRow numrow = numdt.NewEFFS_NUMRow();
        EFFMANGDS.EFFS_MANGRATERow raterow = getEFFMANGRATE(yy, seq, nobr);

        numrow.nobr = nobr;
        numrow.yy = yy;
        numrow.seq = seq;
        numrow.mangnobr = mangnobr;
      

        if (selfapprrow != null)
        {
            if (!selfapprrow.IsrotetNull())
                numrow.ratet = selfapprrow.rotet;

            numrow.apprnum = selfapprrow.mangapprnum;

            if (raterow != null)
            {
                numrow.apprrate = raterow.arrprate;
                numrow.apprratenum = Math.Round(numrow.apprnum * raterow.arrprate/100, 1, MidpointRounding.AwayFromZero);
            }
            else
            {
                numrow.apprrate = selfapprrow.rate;
                numrow.apprratenum = selfapprrow.ratenum;
            }
            numrow.name = selfapprrow.mangname;
            numrow.mangnobr = selfapprrow.mangname;
        }
        else
        {
            numrow.apprnum = 0;
            numrow.apprrate = 0;
            numrow.apprratenum = 0;
            numrow.name = "";
            numrow.mangnobr = "";
        }
        if (selfcaterow != null)
        {
            numrow.catenum = selfcaterow.mangapprnum;

            if (raterow != null)
            {
                numrow.caterate = raterow.caterate;
                numrow.cateratenum = Math.Round(numrow.catenum * raterow.caterate/100, 1, MidpointRounding.AwayFromZero);
            }
            else
            {
                numrow.caterate = selfcaterow.rate;
                numrow.cateratenum = selfcaterow.ratenum;
            }

            numrow.name = selfcaterow.mangname;
            numrow.mangnobr = selfcaterow.mangname;
        }
        else
        {
            numrow.catenum = 0;
            numrow.caterate = 0;
            numrow.cateratenum = 0;
            numrow.name = "";
            numrow.mangnobr = "";
        }
        numrow.totnum = numrow.cateratenum + numrow.apprratenum;
        numrow.effs = getEffsTitle(numrow.totnum, numID);
        return numrow;
    }










    static public string getEffsTitle(decimal num,string ID)
    {
        string effs = "未評";
        EFFDSTableAdapters.EFFS_NUMITEMTableAdapter numad = new EFFDSTableAdapters.EFFS_NUMITEMTableAdapter();
        EFFDS.EFFS_NUMITEMDataTable numdt = numad.GetDataByNum(num, ID);
        EFFDS.EFFS_NUMITEMRow numrow = null;
        if (numdt.Rows.Count > 0) 
        {
            numrow = (EFFDS.EFFS_NUMITEMRow)numdt.Rows[0];
            effs = numrow.numName;
        }
        return effs;
    }

    static public EFFMANGDS.EFFS_SELFNUMRow getEffsSelfApprNum(int yy,int seq,bool included,string nobr,string templet,string type) 
    {
        EFFMANGDSTableAdapters.EFFS_SELFNUMTableAdapter selfad = new EFFMANGDSTableAdapters.EFFS_SELFNUMTableAdapter();
        EFFMANGDS.EFFS_SELFNUMDataTable selfdt = selfad.GetDataBySafeAppr(yy, seq, included, nobr, templet, type);
        EFFMANGDS.EFFS_SELFNUMRow selfrow = null;
        if (selfdt.Rows.Count > 0) {
            selfrow = (EFFMANGDS.EFFS_SELFNUMRow)selfdt.Rows[0];
        }
        return selfrow;
    }
    static public EFFMANGDS.EFFS_MANGNUMRow getEffsMangApprNum(int yy, int seq, bool included, string nobr, string templet, string type,string mangnobr)
    {
        EFFMANGDSTableAdapters.EFFS_MANGNUMTableAdapter mangad = new EFFMANGDSTableAdapters.EFFS_MANGNUMTableAdapter();
        EFFMANGDS.EFFS_MANGNUMDataTable mangdt = mangad.GetDataByMangApprNum( yy,seq,included, nobr,templet, type, mangnobr);
        EFFMANGDS.EFFS_MANGNUMRow mangrow = null;
        if (mangdt.Rows.Count > 0)
        {
            mangrow = (EFFMANGDS.EFFS_MANGNUMRow)mangdt.Rows[0];
        }
        return mangrow;
    }

    static public EFFMANGDS.EFFS_SELFNUMRow getEffsSelfCateNum(int yy, int seq, string nobr,  string type ,string templet)
    {
        EFFMANGDSTableAdapters.EFFS_SELFNUMTableAdapter selfad = new EFFMANGDSTableAdapters.EFFS_SELFNUMTableAdapter();
        EFFMANGDS.EFFS_SELFNUMDataTable selfdt = selfad.GetDataBySafeCate(templet, yy, seq, nobr, type);
        EFFMANGDS.EFFS_SELFNUMRow selfrow = null;
        if (selfdt.Rows.Count > 0)
        {
            selfrow = (EFFMANGDS.EFFS_SELFNUMRow)selfdt.Rows[0];
        }
        return selfrow;
    }

    static public EFFMANGDS.EFFS_MANGNUMRow getEffsMangCateNum(string templet, int yy, int seq, string nobr, string type,string mangnobr)
    {
        EFFMANGDSTableAdapters.EFFS_MANGNUMTableAdapter mangad = new EFFMANGDSTableAdapters.EFFS_MANGNUMTableAdapter();
        EFFMANGDS.EFFS_MANGNUMDataTable mangdt = mangad.GetDataByMangCateNum(templet, yy, seq, nobr, type, mangnobr);
        EFFMANGDS.EFFS_MANGNUMRow mangrow = null;
        if (mangdt.Rows.Count > 0)
        {
            mangrow = (EFFMANGDS.EFFS_MANGNUMRow)mangdt.Rows[0];
        }
        return mangrow;
    }
   
    static public EFFDS.EFFS_ATTENDRow getEffsAttend(int ID)
    {
        EFFDSTableAdapters.EFFS_ATTENDTableAdapter attad = new EFFDSTableAdapters.EFFS_ATTENDTableAdapter();
        EFFDS.EFFS_ATTENDDataTable attdt = attad.GetDataByID(ID);
        EFFDS.EFFS_ATTENDRow attrow = null;
        if (attdt.Rows.Count > 0)
        {
            attrow = (EFFDS.EFFS_ATTENDRow)attdt.Rows[0];
        }
        return attrow;
    }
    static public DateTime getEffsAttendStdDate(int yy,int seq)
    {
        DateTime value = DateTime.Now;
        EFFDSTableAdapters.EFFS_ATTENDTableAdapter attad = new EFFDSTableAdapters.EFFS_ATTENDTableAdapter();
        EFFDS.EFFS_ATTENDDataTable attdt = attad.GetDataByYear(yy,seq);
        EFFDS.EFFS_ATTENDRow attrow = null;
        if (attdt.Rows.Count > 0)
        {
            attrow = (EFFDS.EFFS_ATTENDRow)attdt.Rows[0];
            value = attrow.StdDate;
        }
        return value;
    }
    static public EFFDS.EFFS_ATTENDRow getEffsAttend(int yy,int seq)
    {
        EFFDSTableAdapters.EFFS_ATTENDTableAdapter attad = new EFFDSTableAdapters.EFFS_ATTENDTableAdapter();
        EFFDS.EFFS_ATTENDDataTable attdt = attad.GetDataByYear(yy,seq);
        EFFDS.EFFS_ATTENDRow attrow = null;
        if (attdt.Rows.Count > 0)
        {
            attrow = (EFFDS.EFFS_ATTENDRow)attdt.Rows[0];
        }
        return attrow;
    }

    static public EFFDS.EFFS_ATTENDDataTable getEffsAttendDataTable()
    {
        EFFDSTableAdapters.EFFS_ATTENDTableAdapter attad = new EFFDSTableAdapters.EFFS_ATTENDTableAdapter();
        EFFDS.EFFS_ATTENDDataTable attdt = attad.GetData();
        return attdt;
    }



    static public EFFDS.EFFS_BASERow getEffsBase(string yy, string seq, string nobr)
    {
        EFFDSTableAdapters.EFFS_BASETableAdapter basead = new EFFDSTableAdapters.EFFS_BASETableAdapter();
        EFFDS.EFFS_BASEDataTable basedt = basead.GetDataBySelectNobr(yy, seq, nobr);
        EFFDS.EFFS_BASERow baserow = null;
        if (basedt.Rows.Count > 0) {
            baserow = (EFFDS.EFFS_BASERow)basedt.Rows[0];
        }
        return baserow;
    }
    static public EFFDS.EFFS_BASEDataTable getEffsBaseDT(string yy, string seq, string nobr)
    {
        EFFDSTableAdapters.EFFS_BASETableAdapter basead = new EFFDSTableAdapters.EFFS_BASETableAdapter();
        EFFDS.EFFS_BASEDataTable basedt = basead.GetDataBySelectNobr(yy, seq, nobr);

        return basedt;
    }

    static public EFFDS.EFFS_BASEDataTable getEffsBases(string yy, string seq, ArrayList deptA, string notNobr)
    {
        EFFDSTableAdapters.EFFS_BASETableAdapter effbasead = new EFFDSTableAdapters.EFFS_BASETableAdapter();
        EFFDS.EFFS_BASEDataTable effbasedt = new EFFDS.EFFS_BASEDataTable();
        for (int i = 0; i < deptA.Count; i++)
        {
            effbasedt.Merge(effbasead.GetDataBySelectDeptANotNobr(yy, seq, deptA[i].ToString(), notNobr));
        }
        return effbasedt;
    }
//////////////////////////////////////////////////////////////////////////////////////////////////////////
////
////       組織
////
//////////////////////////////////////////////////////////////////////////////////////////////////////////

    static public string getDeptADeptGroup(string dept)
    {
        HRDSTableAdapters.DEPTATableAdapter deptaad = new HRDSTableAdapters.DEPTATableAdapter();
        HRDS.DEPTADataTable deptadt = deptaad.GetDataByDept(dept);
        string groupDept = "";
        if (deptadt.Rows.Count > 0)
        {
            HRDS.DEPTARow deptrow = (HRDS.DEPTARow)deptadt.Rows[0];
            groupDept = deptrow.DEPT_GROUP;
        }
        else
        {
            CS.ErrorLog("JB", "getDeptADeptGroup(dept)", "找不到指定部門資料(" + dept + ")");
        }
        return groupDept;
    }

    static public string getMangFromNobr(string nobr,string adate)
    {
        string mangnobr = "";
        string dept = "";
        EFFDS.EMPINFODataTableRow row = getEmpInfo(nobr,adate);
        if (row != null)
        {
            if (row.MANG)
            {
                dept = getDeptADeptGroup(row.DEPTM);
            }
            else
            {
                dept = row.DEPTM;
            }
            mangnobr = getMangFromDept(dept,adate);
        }
        else
        {
            CS.ErrorLog("JB", "getMangFromNobr(nobr)", "找不到員工資料(" + nobr + ")");
        }
        return mangnobr;
    }

    static public ArrayList getMangsFromNobr(string nobr, string adate)
    {
        string mangnobr = "";
        string dept = "";
        ArrayList al = new ArrayList();
        EFFDS.EMPINFODataTableRow row = getEmpInfo(nobr, adate);
        if (row != null)
        {
            if (row.MANG)
            {
                dept = getDeptADeptGroup(row.DEPTM);
            }
            else
            {
                dept = row.DEPTM;
            }
            al = getMangsFromDept(dept, adate);
        }
        else
        {
            CS.ErrorLog("JB", "getMangFromNobr(nobr)", "找不到員工資料(" + nobr + ")");
        }
        return al;
    }

    static public ArrayList getMangsFromDept(string dept, string adate) {
        HRDSTableAdapters.DeptAMangTableAdapter deptaad = new HRDSTableAdapters.DeptAMangTableAdapter();
        HRDS.DeptAMangDataTableDataTable deptadt = deptaad.GetData(DateTime.Parse(adate));
        bool notFind = true;
        string indexDept = dept;
        string mangnobr = "";
        int indexCount = 0;
        ArrayList al = new ArrayList();
        do
        {
            indexCount++;
            HRDS.DeptAMangDataTableRow[] deptrows = (HRDS.DeptAMangDataTableRow[])deptadt.Select("D_NO ='" + indexDept + "'");
            if (deptrows.Length > 0)
            {
                if (deptrows[0].dept_group.Trim().Equals(indexDept))
                {
                    notFind = false;
                    mangnobr = "";
                    CS.ErrorLog("JB", "getMang(dept)", "部門代碼與上層部門相同(" + indexDept + ")");
                }
                else
                {

                    if (!deptrows[0].IsNOBRNull())
                    {
                        for (int i = 0; i < deptrows.Length; i++)
                        {
                            al.Add(deptrows[i].NOBR.Trim());

                        }
                        notFind = false;
//                        mangnobr = deptrows[0].NOBR;

                    }
                    else
                    {
                        notFind = true;
                        indexDept = deptrows[0].dept_group;

                    }
                }
            }
            else
            {
                notFind = false;
                mangnobr = "";
                CS.ErrorLog("JB", "getMang(dept)", "找不到指定的部門(" + indexDept + ")");
            }

            if (indexCount >= 10)
            {
                notFind = false;
                mangnobr = "";
            }
        } while (notFind);

        return al;
    
    
    }
    
    static public string getMangFromDept(string dept,string adate) 
    {
        HRDSTableAdapters.DeptAMangTableAdapter deptaad = new HRDSTableAdapters.DeptAMangTableAdapter();
        HRDS.DeptAMangDataTableDataTable deptadt = deptaad.GetData(DateTime.Parse(adate));
        bool notFind = true;
        string indexDept = dept;
        string mangnobr = "" ;
        int indexCount = 0;
        do
        {
            indexCount++;
            HRDS.DeptAMangDataTableRow[] deptrows = (HRDS.DeptAMangDataTableRow[])deptadt.Select("D_NO ='" + indexDept + "'");
            if (deptrows.Length > 0)
            {
                if (deptrows[0].dept_group.Trim().Equals(indexDept))
                {
                    notFind = false;
                    mangnobr = "";
                    CS.ErrorLog("JB", "getMang(dept)", "部門代碼與上層部門相同(" + indexDept + ")");
                }
                else
                {
                    if (!deptrows[0].IsNOBRNull())
                    {
                        notFind = false;
                        mangnobr = deptrows[0].NOBR;
                    }
                    else
                    {
                        notFind = true;
                        indexDept = deptrows[0].dept_group;

                    }
                }
            }
            else
            {
                notFind = false;
                mangnobr = "";
                CS.ErrorLog("JB", "getMang(dept)", "找不到指定的部門(" + indexDept + ")");
            }

            if (indexCount >= 10) 
            {
                notFind = false;
                mangnobr = "";
            }
        } while (notFind);

        return mangnobr;
    
    }

    static public EFFDS.EMPINFODataTableRow getEmpInfoForNobrOrName(string Value,string adate)
    {
        EFFDSTableAdapters.EMPINFOTableAdapter empad = new EFFDSTableAdapters.EMPINFOTableAdapter();
        EFFDS.EMPINFODataTableDataTable empdt = empad.GetDataByNobrOrName(adate,Value);
        EFFDS.EMPINFODataTableRow emprow = null;
        if (empdt.Rows.Count > 0)
        {
            emprow = (EFFDS.EMPINFODataTableRow)empdt.Rows[0];
        }
        return emprow;
    }



    static public EFFDS.EMPINFODataTableRow getEmpInfo(string nobr,string adate)
    {
        EFFDSTableAdapters.EMPINFOTableAdapter empad = new EFFDSTableAdapters.EMPINFOTableAdapter();
        EFFDS.EMPINFODataTableDataTable empdt = empad.GetDataByNobr(nobr,DateTime.Parse(adate));
        EFFDS.EMPINFODataTableRow emprow = null;
        if (empdt.Rows.Count > 0)
        {
            emprow = (EFFDS.EMPINFODataTableRow)empdt.Rows[0];
        }
        return emprow;
    }

    static public EFFDS.EMPINFODataTableDataTable getDeptEmpInfo(string dept,string adate) 
    {
        EFFDSTableAdapters.EMPINFOTableAdapter empad = new EFFDSTableAdapters.EMPINFOTableAdapter();
        EFFDS.EMPINFODataTableDataTable empdt = empad.GetDataByDept(adate,dept);
        return empdt;
    }
    static public EFFDS.EMPINFODataTableDataTable getDeptEmpInfo(string dept, string not_in_nobr,string adate)
    {
        EFFDSTableAdapters.EMPINFOTableAdapter empad = new EFFDSTableAdapters.EMPINFOTableAdapter();
        EFFDS.EMPINFODataTableDataTable empdt = empad.GetDataByDeptNotNobr(adate,dept, not_in_nobr);
        return empdt;
    }
    static public EFFDS.EMPINFODataTableDataTable getDeptMEmpInfo(string deptM,string adate)
    {
        EFFDSTableAdapters.EMPINFOTableAdapter empad = new EFFDSTableAdapters.EMPINFOTableAdapter();
        EFFDS.EMPINFODataTableDataTable empdt = empad.GetDataByDeptM(adate,deptM);
        return empdt;
    }

    static public EFFDS.EMPINFODataTableDataTable getDeptMEmpInfo(string deptM, string not_in_nobr,string adate)
    {
        EFFDSTableAdapters.EMPINFOTableAdapter empad = new EFFDSTableAdapters.EMPINFOTableAdapter();
        EFFDS.EMPINFODataTableDataTable empdt = empad.GetDataByDeptMNotNobr(adate,deptM, not_in_nobr);
        return empdt;
    }



    public EFFDS.EMPINFODataTableDataTable getDeptChildEmpInfo(string Dept,string adate) 
    {
        EFFDS.EMPINFODataTableDataTable empdt = new EFFDS.EMPINFODataTableDataTable();
        ArrayList al = getChilDept(Dept);
        for (int i = 0; i < al.Count; i++) 
        {
            empdt.Merge(getDeptEmpInfo(al[i].ToString(),adate));
        }

        return empdt;
    }
    public EFFDS.EMPINFODataTableDataTable getDeptChildEmpInfo(string Dept,string not_in_nobr,string adate)
    {
        EFFDS.EMPINFODataTableDataTable empdt = new EFFDS.EMPINFODataTableDataTable();
        ArrayList al = getChilDept(Dept);
        for (int i = 0; i < al.Count; i++)
        {
            empdt.Merge(getDeptEmpInfo(al[i].ToString(), not_in_nobr,adate));
        }

        return empdt;
    }

    public EFFDS.EMPINFODataTableDataTable getDeptMChildEmpInfo(string DeptM,string adate)
    {
        EFFDS.EMPINFODataTableDataTable empdt = new EFFDS.EMPINFODataTableDataTable();
        ArrayList al = getChilDeptM(DeptM);
        for (int i = 0; i < al.Count; i++)
        {
            empdt.Merge(getDeptMEmpInfo(al[i].ToString(),adate));
        }

        return empdt;

    }
    public EFFDS.EMPINFODataTableDataTable getDeptMChildEmpInfo(string DeptM, string not_in_nobr,string adate)
    {
        EFFDS.EMPINFODataTableDataTable empdt = new EFFDS.EMPINFODataTableDataTable();
        ArrayList al = getChilDeptM(DeptM);
        for (int i = 0; i < al.Count; i++)
        {
            empdt.Merge(getDeptMEmpInfo(al[i].ToString(), not_in_nobr,adate));
        }

        return empdt;

    }

    public ArrayList getChilDeptM(string deptM)
    {
        HRDSTableAdapters.DEPTATableAdapter org_deptad = new HRDSTableAdapters.DEPTATableAdapter();
        HRDS.DEPTADataTable org_dept = org_deptad.GetData();
        ArrayList al = new ArrayList();

        DataView myDataView = org_dept.DefaultView;

        myDataView.RowFilter = "d_no = '" + deptM + "'";
        al.Add(deptM);
        if (myDataView.Count == 0)
            return al;

        setNote(al, org_dept, myDataView[0]["d_no"].ToString());
        return al;
    }



    public ArrayList getChilDept(string dept)
    {
        HRDSTableAdapters.DEPTTableAdapter org_deptad = new HRDSTableAdapters.DEPTTableAdapter();
        HRDS.DEPTDataTable org_dept = org_deptad.GetData();
        ArrayList al = new ArrayList();

        DataView myDataView = org_dept.DefaultView;

        myDataView.RowFilter = "d_no = '" + dept + "'";
        al.Add(dept);
        if (myDataView.Count == 0)
            return al;

        setNote(al, org_dept, myDataView[0]["d_no"].ToString());
        return al;
    }

    void setNote(ArrayList al, DataTable dt, string indexNo)
    {
        DataView myDataView1 = dt.DefaultView;
        myDataView1.RowFilter = "DEPT_GROUP = '" + indexNo + "'";
        int count = 0;
        count = myDataView1.Count;
        if (count > 0)
        {
            for (int i = 0; i < count; i++)
            {
                myDataView1.RowFilter = "DEPT_GROUP = '" + indexNo + "'";
                if (!al.Contains(myDataView1[i]["d_no"].ToString().Trim()))
                {
                    al.Add(myDataView1[i]["d_no"].ToString().Trim());
                    setNote(al, dt, myDataView1[i]["d_no"].ToString().Trim());
                }
            }
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////
    ////       主管
    ////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////

    static public EFFMANGDS.EFFS_ASSIGNAPPENDDataTable getAssign(int yy,int seq ,string mangnobr)
    {
        EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter assad = new EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter();
        EFFMANGDS.EFFS_ASSIGNAPPENDDataTable essdt = assad.GetDataByMang(mangnobr, yy, seq);

        return essdt;

    }
    static public EFFMANGDS.EFFS_ASSIGNAPPENDDataTable getAssignMang(int yy, int seq, string AssignMang)
    {
        EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter assad = new EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter();
        EFFMANGDS.EFFS_ASSIGNAPPENDDataTable essdt = assad.GetDataByAssign(AssignMang, yy, seq);

        return essdt;

    }
    static public EFFMANGDS.EFFS_ASSIGNAPPENDDataTable getAssignEmpNobr(int yy, int seq, string nobr)
    {
        EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter assad = new EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter();
        EFFMANGDS.EFFS_ASSIGNAPPENDDataTable essdt = assad.GetDataByEmpNobr(yy, seq, nobr);

        return essdt;

    }


    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////
    ////       說明
    ////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    static public string getNote(string app)
    {
        string note ="";
        EFFMANGDSTableAdapters.EFFS_NOTETableAdapter notead = new EFFMANGDSTableAdapters.EFFS_NOTETableAdapter();
        EFFMANGDS.EFFS_NOTEDataTable notedt = notead.GetDataByApp(app);
        if (notedt.Rows.Count > 0)
        {
            EFFMANGDS.EFFS_NOTERow noterow = (EFFMANGDS.EFFS_NOTERow)notedt.Rows[0];
            if (!noterow.IsnoteNull())
                note = noterow.note;
        }
        return note;
    }
}
