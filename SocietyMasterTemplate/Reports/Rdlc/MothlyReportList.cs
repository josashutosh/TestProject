using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocietySquareDAL;
using System.Data;
using SocietySquareDAL;
using SocietySquareEntity;
namespace EsquareMasterTemplate.Reports.Rdlc
{ 
    public class MothlyReportList
    {
        public int MaintenanceID { get; set; }
        public string PropertyType { get; set; }
        public int CalculationMethodId { get; set; }
        public float PropertyTaxes { get; set; }
        public float WaterCharges { get; set; }
        public float ElectricityCharges { get; set; }
        public float RepairsMaintenanceFund { get; set; }
        public float LiftCharges { get; set; }
        public float SinkingFund { get; set; }
        public float ServiceCharges { get; set; }
        public float CarParkingCharges { get; set; }
        public float InterestonDefaultedCharges { get; set; }
        public float RepaymentInstmntLoanInterest { get; set; }
        public float NonOccupancyCharges { get; set; }
        public float InsuranceCharges { get; set; }
        public float LeaseRent { get; set; }
        public float NonAgriculturalTax { get; set; }
        public float OtherCharges { get; set; }
        public float TotalMaintenanceSum { get; set; }
        public float MaintenancePerFlat { get; set; }
        public float PerSquareFeetRate { get; set; }
        public int FixedSqft { get; set; }
        public float FixedRate { get; set; }
        public int AdditionalSqft { get; set; }
        public float AdditionalSqftRate { get; set; }
        public string EffectiveFromDate { get; set; }
        public string EffectiveToDate { get; set; }
        public int TotalArea { get; set; }
        public int FlatCount { get; set; }  
        public string CalculationMethod { get; set; }
        public string OwnerName { get; set; }
        public string FlatNumber { get; set; }
        public string BusinessType { get; set; }
        public string LicenseNo { get; set; }
        public string ShopDescription { get; set; }
        public float AmountBalance { get; set; }
        public string BuildingName { get; set; }
        public float SqFeetAmount { get; set; }
        public string Login_ID { get; set; }
        public string EmailID { get; set; }
        public string EffectiveFromDate1 { get; set; }
        public string Output { get; set; }

            public IList GetData()
            {

                clsReportDal objReportDal = new clsReportDal();
                clsReportParameterEntity objReportEntity = new clsReportParameterEntity();
                DataSet ds = new DataSet();

                if (Convert.ToString(HttpContext.Current.Session["Login_Type"]) == "Admin")
                       {
                           objReportEntity.Login_Type = HttpContext.Current.Session["Login_Type"].ToString();
                           objReportEntity.flatNumber = 2;
                           objReportEntity.ReportDate = "01/01/2015"; 
                       }
                if (Convert.ToString(HttpContext.Current.Session["Login_Type"]) == "SocietyMember")
                {
                    objReportEntity.Login_Type = HttpContext.Current.Session["Login_Type"].ToString();
                    objReportEntity.flatNumber = 3;
                    objReportEntity.ReportDate = "01/02/2015"; 
                }


                ds = (DataSet)objReportDal.GetMonthlyDetail(objReportEntity);

                List<MothlyReportList> M = new List<MothlyReportList>();
                

                if (ds.Tables[0].Rows.Count > 0)
                {

                    if (Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"]) == 1)
                    {
                        MothlyReportList MR = new MothlyReportList();

                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                           MR.MaintenanceID = Convert.ToInt32(ds.Tables[0].Rows[0]["MaintenanceID"].ToString());
                           MR.PropertyType = ds.Tables[0].Rows[0]["PropertyType"].ToString();
                           MR.CalculationMethodId = Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"].ToString());
                           MR.PropertyTaxes = float.Parse(ds.Tables[0].Rows[0]["PropertyTaxes"].ToString());
                           MR.WaterCharges = float.Parse(ds.Tables[0].Rows[0]["WaterCharges"].ToString());
                           MR.ElectricityCharges = float.Parse(ds.Tables[0].Rows[0]["ElectricityCharges"].ToString());
                           MR.RepairsMaintenanceFund = float.Parse(ds.Tables[0].Rows[0]["RepairsMaintenanceFund"].ToString());
                           MR.LiftCharges = float.Parse(ds.Tables[0].Rows[0]["LiftCharges"].ToString());
                           MR.SinkingFund = float.Parse(ds.Tables[0].Rows[0]["SinkingFund"].ToString());
                           MR.ServiceCharges = float.Parse(ds.Tables[0].Rows[0]["ServiceCharges"].ToString());
                           MR.CarParkingCharges = float.Parse(ds.Tables[0].Rows[0]["CarParkingCharges"].ToString());
                           MR.InterestonDefaultedCharges = float.Parse(ds.Tables[0].Rows[0]["InterestonDefaultedCharges"].ToString());
                           MR.RepaymentInstmntLoanInterest = float.Parse(ds.Tables[0].Rows[0]["RepaymentInstmntLoanInterest"].ToString());
                           MR.NonOccupancyCharges = float.Parse(ds.Tables[0].Rows[0]["NonOccupancyCharges"].ToString());
                           MR.InsuranceCharges = float.Parse(ds.Tables[0].Rows[0]["InsuranceCharges"].ToString());
                           MR.LeaseRent = float.Parse(ds.Tables[0].Rows[0]["LeaseRent"].ToString());
                           MR.NonAgriculturalTax = float.Parse(ds.Tables[0].Rows[0]["NonAgriculturalTax"].ToString());
                           MR.OtherCharges = float.Parse(ds.Tables[0].Rows[0]["OtherCharges"].ToString());
                           MR.TotalMaintenanceSum = float.Parse(ds.Tables[0].Rows[0]["TotalMaintenanceSum"].ToString());
                           MR.MaintenancePerFlat = float.Parse(ds.Tables[0].Rows[0]["MaintenancePerFlat"].ToString());
                           MR.EffectiveFromDate = ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString();
                           MR.EffectiveToDate = ds.Tables[0].Rows[0]["EffectiveToDate"].ToString();
                           MR.FlatCount = Convert.ToInt32(ds.Tables[0].Rows[0]["FlatCount"].ToString());
                           MR.CalculationMethod = ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                           MR.OwnerName =ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                           MR.FlatNumber =ds.Tables[0].Rows[0]["FlatNumber"].ToString();
                           MR.BusinessType = ds.Tables[0].Rows[0]["BusinessType"].ToString();
                           MR.LicenseNo  = ds.Tables[0].Rows[0]["LicenseNo"].ToString();
                           MR.ShopDescription = ds.Tables[0].Rows[0]["ShopDescription"].ToString();
                           MR.AmountBalance = float.Parse(ds.Tables[0].Rows[0]["AmountBalance"].ToString());
                           MR.BuildingName = ds.Tables[0].Rows[0]["BuildingName"].ToString();
                           MR.SqFeetAmount = float.Parse(ds.Tables[0].Rows[0]["SqFeetAmount"].ToString());
                           MR.Login_ID =ds.Tables[0].Rows[0]["Login_ID"].ToString();
                           MR.EmailID = ds.Tables[0].Rows[0]["EmailID"].ToString();
                           MR.EffectiveFromDate = ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString();
                         

                        }

                        M.Add(MR);
                    }
                    else if (Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"]) == 2)
                    {
                        MothlyReportList SF = new MothlyReportList();

                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            SF.MaintenanceID = Convert.ToInt32(ds.Tables[0].Rows[0]["MaintenanceID"].ToString());
                            SF.PropertyType = ds.Tables[0].Rows[0]["PropertyType"].ToString();
                            SF.CalculationMethodId = Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"].ToString());
                            SF.TotalArea = Convert.ToInt32(ds.Tables[0].Rows[0]["TotalArea"].ToString());
                            SF.PerSquareFeetRate = float.Parse(ds.Tables[0].Rows[0]["PerSquareFeetRate"].ToString());

                            SF.EffectiveFromDate = ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString();
                            SF.EffectiveToDate = ds.Tables[0].Rows[0]["EffectiveToDate"].ToString();

                          SF.CalculationMethod = ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                          SF.OwnerName = ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                          SF.FlatNumber = ds.Tables[0].Rows[0]["FlatNumber"].ToString();
                          SF.BusinessType = ds.Tables[0].Rows[0]["BusinessType"].ToString();
                          SF.LicenseNo = ds.Tables[0].Rows[0]["LicenseNo"].ToString();
                          SF.ShopDescription = ds.Tables[0].Rows[0]["ShopDescription"].ToString();
                          SF.AmountBalance = float.Parse(ds.Tables[0].Rows[0]["AmountBalance"].ToString());
                          SF.BuildingName = ds.Tables[0].Rows[0]["BuildingName"].ToString();
                          SF.SqFeetAmount = float.Parse(ds.Tables[0].Rows[0]["SqFeetAmount"].ToString());
                          SF.Login_ID = ds.Tables[0].Rows[0]["Login_ID"].ToString();
                          SF.EmailID = ds.Tables[0].Rows[0]["EmailID"].ToString();
                          SF.EffectiveFromDate = ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString();
                         
                        }
                        M.Add(SF);
                    }
                    else if (Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"]) == 3)
                    {
                        MothlyReportList PF = new MothlyReportList();

                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            PF.MaintenanceID = Convert.ToInt32(ds.Tables[0].Rows[0]["MaintenanceID"].ToString());
                            PF.PropertyType = ds.Tables[0].Rows[0]["PropertyType"].ToString();
                            PF.CalculationMethodId = Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"].ToString());
                            PF.FixedSqft = Convert.ToInt32(ds.Tables[0].Rows[0]["FixedSqft"].ToString());
                            PF.FixedRate = float.Parse(ds.Tables[0].Rows[0]["FixedRate"].ToString());
                            PF.AdditionalSqft = Convert.ToInt32(ds.Tables[0].Rows[0]["AdditionalSqft"].ToString());
                            PF.AdditionalSqftRate = float.Parse(ds.Tables[0].Rows[0]["AdditionalSqftRate"].ToString());
                            PF.EffectiveFromDate = ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString();
                            PF.EffectiveToDate = ds.Tables[0].Rows[0]["EffectiveToDate"].ToString();
                            PF.CalculationMethod = ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                            PF.OwnerName = ds.Tables[0].Rows[0]["CalculationMethod"].ToString();
                            PF.FlatNumber =ds.Tables[0].Rows[0]["FlatNumber"].ToString();
                            PF.BusinessType = ds.Tables[0].Rows[0]["BusinessType"].ToString();
                            PF.LicenseNo = ds.Tables[0].Rows[0]["LicenseNo"].ToString();
                            PF.ShopDescription = ds.Tables[0].Rows[0]["ShopDescription"].ToString();
                            PF.AmountBalance = float.Parse(ds.Tables[0].Rows[0]["AmountBalance"].ToString());
                            PF.BuildingName = ds.Tables[0].Rows[0]["BuildingName"].ToString();
                            //PF.SqFeetAmount = float.Parse(ds.Tables[0].Rows[0]["SqFeetAmount"].ToString());
                            PF.Login_ID = ds.Tables[0].Rows[0]["Login_ID"].ToString();
                            PF.EmailID = ds.Tables[0].Rows[0]["EmailID"].ToString();
                            PF.EffectiveFromDate = ds.Tables[0].Rows[0]["EffectiveFromDate"].ToString();
                         
                        }
                        M.Add(PF);
                    }
                    else if (Convert.ToInt32(ds.Tables[0].Rows[0]["CalculationMethodId"]) == 4)
                    {
                        MothlyReportList MR = new MothlyReportList();

                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {

                        }

                        M.Add(MR);
                    }



                }
                else 
                {
                     MothlyReportList MN = new MothlyReportList();
                     MN.Output = "No Record Found";
                     M.Add(MN);    

                }

                return M;
            }
        

        
    }
}