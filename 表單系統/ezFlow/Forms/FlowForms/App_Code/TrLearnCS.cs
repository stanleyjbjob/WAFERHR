using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// TrLearnCS 的摘要描述
/// </summary>
public class TrLearnCS
{
	public TrLearnCS()
	{
		//
		// TODO: 在此加入建構函式的程式碼
		//
	}

    /// <summary>
    /// 資料格式的檢查
    /// </summary>
    /// <param name="Value">待檢查的輸入資料</param>
    /// <param name="_InputType">檢查的類型</param>
    /// <param name="Msg">格式不符時所傳回的訊息</param>
    static public void InputCheck(string Value, InputType _InputType, string Msg)
    {
        //if (Value == null)
        //    throw new Exception(Msg);

        if (_InputType == InputType.NotNull)
        {
            if (Value.Trim().Length == 0)
            {
                throw new Exception(Msg);
            }
        }
        else if (_InputType == InputType.DateTime)
        {
            try
            {
                DateTime dt = Convert.ToDateTime(Value);
            }
            catch (FormatException)
            {
                throw new Exception(Msg);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        else if (_InputType == InputType.Integer)
        {
            try
            {
                int i = Convert.ToInt32(Value);
            }
            catch (FormatException)
            {
                throw new Exception(Msg);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        else if (_InputType == InputType.Decimal)
        {
            try
            {
                decimal i = Convert.ToDecimal(Value);
            }
            catch (FormatException)
            {
                throw new Exception(Msg);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        else if (_InputType == InputType.Time)
        {
            try
            {
                //大小必須為4
                if (Value.Length != 4)
                    throw new Exception(Msg);
                //確認是否為數字型態
                Convert.ToInt32(Value);
                int valHour = int.Parse(Value.Substring(0, 2));
                int valMin = int.Parse(Value.Substring(2, 2));
                if (valHour > 23 || valHour < 0)
                    throw new Exception(Msg);
                if (valMin > 59 || valMin < 0)
                    throw new Exception(Msg);
                
            }
            catch (FormatException)
            {
                throw new Exception(Msg);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
    /// <summary>
    /// 檢查資料的長度是否在規定範圍內
    /// </summary>
    /// <param name="Value">資料</param>
    /// <param name="LimitLength">設定的長度</param>
    /// <param name="isMaxLength">設定的長度是否為最大長度</param>
    /// <param name="Msg"></param>
    static public void InputCheck(string Value, int LimitLength, bool isMaxLength,string Msg)
    {
        if (isMaxLength)
        {
            if (Value.Length > LimitLength)
                throw new Exception(Msg);
        }
        else
        {
            if (Value.Length < LimitLength)
                throw new Exception(Msg);
        }
    }
    /// <summary>
    /// 將時間的格式轉換成字串
    /// </summary>
    /// <param name="Time">時間</param>
    /// <returns></returns>
    static public string CovertTimeToString(DateTime Time)
    {
        int valHour = Time.Hour;
        int valMin = Time.Minute;
        string strHour = valHour.ToString();
        string strMin = valMin.ToString();
        //未滿二位數則補0       
        if (valHour < 10)
            strHour = "0" + valHour.ToString();
        if (valMin < 10)
            strMin = "0" + valMin.ToString();
        return strHour + strMin;
    }

    static public decimal GetTimeSpan(DateTime FromDT,DateTime ToDT)
    {
        if (FromDT > ToDT)
            throw new Exception("起始時間不可大於結束時間");
        TimeSpan tmSpan = ToDT - FromDT;
        decimal dcmMin=0;
        if (tmSpan.Minutes>29)
            dcmMin=0.5M;

        decimal value = (tmSpan.Days+1) * (tmSpan.Hours + dcmMin);
        return value;

    }

    static public TrainDS.TRCOSFRow Get_dtTRCOSF_BY_IDNOandAPPLYNO(string idno, string applyno)
    {
        TrainDSTableAdapters.TRCOSFTableAdapter TrcosfTA = new TrainDSTableAdapters.TRCOSFTableAdapter();
        TrainDS.TRCOSFDataTable dtTrcosf = new TrainDS.TRCOSFDataTable();
        TrcosfTA.FillByIDandNO(dtTrcosf, idno, applyno);
        if (dtTrcosf == null || dtTrcosf.Rows.Count == 0)
            return null;
        TrainDS.TRCOSFRow TrcosRow = dtTrcosf.Rows[0] as TrainDS.TRCOSFRow;
        return TrcosRow;
    }

    static public TrLearnedDS.wfTrLearnedSetRow GetTrLearnedSet()
    {
        TrLearnedDSTableAdapters.wfTrLearnedSetTableAdapter TrLndSetTA = new TrLearnedDSTableAdapters.wfTrLearnedSetTableAdapter();
        TrLearnedDS.wfTrLearnedSetDataTable TrLearnedDT = new TrLearnedDS.wfTrLearnedSetDataTable();
        TrLndSetTA.Fill(TrLearnedDT);
        TrLearnedDS.wfTrLearnedSetRow TrLearnedRow = TrLearnedDT.Rows[0] as TrLearnedDS.wfTrLearnedSetRow;
        return TrLearnedRow;
    }

    public enum InputType
    {
        NotNull = 0,
        Integer = 1,
        DateTime = 2,
        Decimal = 3,
        Time=4
    } 
}
