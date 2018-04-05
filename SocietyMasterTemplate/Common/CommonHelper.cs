using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Syncfusion.Pdf.Graphics;
using System.Drawing;
using Syncfusion.Pdf;
using Syncfusion.Pdf.Grid;
using Syncfusion.Pdf.Tables;
using System.Text.RegularExpressions;
using System.Data;
using System.IO;
using System.Text;
using System.Configuration;
using System.Data.OleDb;

namespace EsquareMasterTemplate.Common
{
    public class CommonHelper
    {

        #region baseUrl
        public string GetBaseURL()
        {
            string GetURLBase;
            GetURLBase = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.ApplicationPath;
            return GetURLBase;
        }
        #endregion

        public static void LogOut(string loggedOutPageUrl)
        {
            HttpContext.Current.Session.Abandon();
            //string loggedOutPageUrl = "Logout.aspx";
            HttpContext.Current.Response.Write("&lt;script language='javascript'&gt;");
            HttpContext.Current.Response.Write("function ClearHistory()");
            HttpContext.Current.Response.Write("{");
            HttpContext.Current.Response.Write(" var backlen=history.length;");
            HttpContext.Current.Response.Write(" history.go(-backlen);");
            HttpContext.Current.Response.Write(" window.location.href='" + loggedOutPageUrl + "'; ");
            HttpContext.Current.Response.Write("}");
            HttpContext.Current.Response.Write("&lt;/script&gt;");
        }
        public float AddHeader(PdfDocument doc, string title, string description, string imagepath)
        {
            PdfFont font = new PdfStandardFont(PdfFontFamily.TimesRoman, 24);
            float doubleHeight = font.Height * 2;
            Color activeColor = Color.FromArgb(44, 71, 120);
            int count = Regex.Matches(description, "\n").Count;

            RectangleF rect = new RectangleF(0, 0, doc.Pages[0].GetClientSize().Width, font.Height * (count + 1) + 20 * count);

            //Create page template
            PdfPageTemplateElement header = new PdfPageTemplateElement(rect);

            PdfSolidBrush brush = new PdfSolidBrush(activeColor);

            PdfPen pen = new PdfPen(Color.Black, 1f);
            font = new PdfStandardFont(PdfFontFamily.TimesRoman, 12, PdfFontStyle.Bold);

            //Set formattings for the text
            PdfStringFormat format = new PdfStringFormat();
            format.Alignment = PdfTextAlignment.Center;
            format.LineAlignment = PdfVerticalAlignment.Middle;

            // header.Graphics.DrawString(title, font, brush, new RectangleF(0, 10, header.Width, header.Height), format);//,

            //SizeF imageSize = new SizeF(190F, 45f);
            //Locating the logo on the right corner of the Drawing Surface
            if (imagepath == "" || imagepath == null)
            {
                PointF imageLocation = new PointF(0, 10);

                // PdfImage img = new PdfBitmap(ResolveApplicationDataPath("logo.png", true));
                PdfImage img = new PdfBitmap(imagepath);

                //Draw the image in the Header.
                header.Graphics.DrawImage(img, imageLocation);

            }
            font = new PdfStandardFont(PdfFontFamily.TimesRoman, 12, PdfFontStyle.Bold);
            format = new PdfStringFormat();
            format.Alignment = PdfTextAlignment.Left;
            format.LineAlignment = PdfVerticalAlignment.Top;

            //Draw title
            header.Graphics.DrawString(title, font, brush, new RectangleF(doc.Pages[0].GetClientSize().Width - 275, 10, header.Width, header.Height), format);
            brush = new PdfSolidBrush(Color.Gray);
            font = new PdfStandardFont(PdfFontFamily.TimesRoman, 9, PdfFontStyle.Bold);

            format = new PdfStringFormat();
            format.Alignment = PdfTextAlignment.Left;
            format.LineAlignment = PdfVerticalAlignment.Top;


            activeColor = Color.FromArgb(0, 0, 0);
            brush = new PdfSolidBrush(activeColor);
            header.Graphics.DrawString(description, font, brush, new RectangleF(doc.Pages[0].GetClientSize().Width - 275, 24, header.Width, header.Height - 8), format);
            doc.Template.Top = header;

            return header.Size.Height;

            //Add header template at the top.

        }

        /// <summary>
        /// Adds footer to the document
        /// </summary>
        /// <param name="doc"></param>
        /// <param name="footerText"></param>
        public void AddFooter(PdfDocument doc, string footerText)
        {
            RectangleF rect = new RectangleF(0, 0, doc.Pages[0].GetClientSize().Width, 50);

            //Create a page template
            PdfPageTemplateElement footer = new PdfPageTemplateElement(rect);
            PdfFont font = new PdfStandardFont(PdfFontFamily.Helvetica, 10);

            PdfSolidBrush brush = new PdfSolidBrush(Color.Gray);

            PdfPen pen = new PdfPen(Color.DarkBlue, 3f);
            font = new PdfStandardFont(PdfFontFamily.Helvetica, 6, PdfFontStyle.Bold);
            PdfStringFormat format = new PdfStringFormat();
            format.Alignment = PdfTextAlignment.Center;
            format.LineAlignment = PdfVerticalAlignment.Middle;
            footer.Graphics.DrawString(footerText, font, brush, new RectangleF(0, 18, footer.Width, footer.Height), format);

            format = new PdfStringFormat();
            format.Alignment = PdfTextAlignment.Right;
            format.LineAlignment = PdfVerticalAlignment.Bottom;

            //Create page number field
            PdfPageNumberField pageNumber = new PdfPageNumberField(font, brush);

            //Create page count field
            PdfPageCountField count = new PdfPageCountField(font, brush);

            //Create author field
            PdfDocumentAuthorField authorField = new PdfDocumentAuthorField(font, brush);

            footer.Graphics.DrawString("Page\tof", font, brush, new RectangleF(0, 0, footer.Width - 8, footer.Height + 30), format);
            //Draw current page number
            pageNumber.Draw(footer.Graphics, new PointF(496, 35));

            //Draw number of pages
            count.Draw(footer.Graphics, new PointF(510, 35));

            //Draw number of pages
            //  authorField.Draw(footer.Graphics, new PointF(320, 35));

            //Add the footer template at the bottom
            doc.Template.Bottom = footer;
        }

        public PdfLayoutResult receiptInfo(PdfGraphics graphics, PdfPage page, string CalculationType, string OwnerID, string Date, float Headerheight)
        {
            PdfFont subHeadingFont = new PdfStandardFont(PdfFontFamily.TimesRoman, 13);
            PdfTextElement element;
            PdfLayoutResult result;
            graphics.DrawRectangle(new PdfSolidBrush(new PdfColor(107, 83, 83)), new RectangleF(0, Headerheight, graphics.ClientSize.Width, 30));
            element = new PdfTextElement("Calculation Type  " + CalculationType.ToString(), subHeadingFont);
            element.Brush = PdfBrushes.White;
            result = element.Draw(page, new PointF(10, Headerheight + 7));
            // string currentDate = "DATE " + DateTime.Now.ToString("MM/dd/yyyy");
            SizeF textSize = subHeadingFont.MeasureString(Date);
            graphics.DrawString(Date, subHeadingFont, element.Brush, new PointF(graphics.ClientSize.Width - textSize.Width - 10, Headerheight + 7));
            return result;
        }

        public PdfLayoutResult receiptInfoMonthy(PdfGraphics graphics, PdfPage page, string CalculationType, string Date, string textMessage, float Headerheight)
        {
            PdfFont subHeadingFont = new PdfStandardFont(PdfFontFamily.TimesRoman, 13);
            PdfTextElement element;
            PdfLayoutResult result;
            graphics.DrawRectangle(new PdfSolidBrush(new PdfColor(107, 83, 83)), new RectangleF(0, Headerheight, graphics.ClientSize.Width, 30));
            element = new PdfTextElement(textMessage, subHeadingFont);
            element.Brush = PdfBrushes.White;
            result = element.Draw(page, new PointF((graphics.ClientSize.Width / 4), Headerheight + 10));

            return result;
        }

        public PdfLayoutResult OwnerandpaymentDetail(PdfLayoutResult result, PdfGraphics graphics, PdfPage page, string Ownerdetail, string PaymentDetail)
        {
            PdfTextElement element;
            PdfFont subHeadingFont = new PdfStandardFont(PdfFontFamily.TimesRoman, 10);
            element = new PdfTextElement("BILL TO ", subHeadingFont);
            element.Brush = new PdfSolidBrush(new PdfColor(0, 0, 0));
            element.Draw(page, new PointF(10, result.Bounds.Bottom + 25));

            //payment

            element = new PdfTextElement("PaymentDetail", subHeadingFont);
            element.Brush = new PdfSolidBrush(new PdfColor(0, 0, 0));
            SizeF textSize = subHeadingFont.MeasureString("PaymentDetail");
            result = element.Draw(page, new PointF(graphics.ClientSize.Width - textSize.Width - 110, result.Bounds.Bottom + 25));

            graphics.DrawLine(new PdfPen(new PdfColor(126, 151, 173), 0.70f), new PointF(0, result.Bounds.Bottom + 3), new PointF(graphics.ClientSize.Width, result.Bounds.Bottom + 3));


            element = new PdfTextElement(Ownerdetail, new PdfStandardFont(PdfFontFamily.TimesRoman, 10));
            element.Brush = new PdfSolidBrush(new PdfColor(89, 89, 93));
            element.Draw(page, new RectangleF(10, result.Bounds.Bottom + 5, graphics.ClientSize.Width / 2, 100));

            //Payment Detail

            element = new PdfTextElement(PaymentDetail, new PdfStandardFont(PdfFontFamily.TimesRoman, 10));
            element.Brush = new PdfSolidBrush(new PdfColor(89, 89, 93));
            result = element.Draw(page, new RectangleF(graphics.ClientSize.Width - textSize.Width - 130, result.Bounds.Bottom + 5, graphics.ClientSize.Width / 2, 100));


            return result;
        }

        public PdfLayoutResult GeneratePayDetailGrid(PdfLayoutResult result, PdfGraphics graphics, PdfPage page, System.Data.DataSet ds, string GenerateTable, int columncount, int k)
        {

            PdfGrid grid = new PdfGrid();

            if (GenerateTable == "Yes")
            {

                if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 1)
                {
                    DataTable dt = (DataTable)GenerateDatasetToDatatable(ds, "FlatMonthlyFee");
                    grid.DataSource = dt;


                }
                else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 2)
                {
                    DataTable dt = (DataTable)GenerateDatasetToDatatable(ds, "PerSquareFeetRate");
                    grid.DataSource = dt;

                }
                else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 3)
                {
                    DataTable dt = (DataTable)GenerateDatasetToDatatable(ds, "PartialFlatRate");
                    grid.DataSource = dt;

                }
                else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 4)
                {
                    DataTable dt = (DataTable)GenerateDatasetToDatatable(ds, "MixedApproach");
                    grid.DataSource = dt;

                }
                else if (Int32.Parse(ds.Tables[2].Rows[0]["CalculationMethodId"].ToString()) == 5)
                {
                    DataTable dt = (DataTable)GenerateDatasetToDatatable(ds, "LumpsumFee");
                    grid.DataSource = dt;

                }

                PdfGridCellStyle cellStyle = new PdfGridCellStyle();
                cellStyle.Borders.All = PdfPens.White;
                PdfGridRow header = grid.Headers[0];

                PdfGridCellStyle headerStyle = new PdfGridCellStyle();
                headerStyle.Borders.All = new PdfPen(new PdfColor(126, 151, 173));
                headerStyle.BackgroundBrush = new PdfSolidBrush(new PdfColor(107, 83, 83));
                headerStyle.TextBrush = PdfBrushes.White;
                headerStyle.Font = new PdfStandardFont(PdfFontFamily.TimesRoman, 14f, PdfFontStyle.Regular);

                for (int i = 0; i < header.Cells.Count; i++)
                {
                    if (i == 0 || i == 1 || i == 2 || i == 3)
                        header.Cells[i].StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                    else
                        header.Cells[i].StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);
                }

                header.ApplyStyle(headerStyle);
                cellStyle.Borders.Bottom = new PdfPen(new PdfColor(217, 217, 217), 0.70f);
                cellStyle.Font = new PdfStandardFont(PdfFontFamily.TimesRoman, 12f);
                cellStyle.TextBrush = new PdfSolidBrush(new PdfColor(0, 0, 0));


                foreach (PdfGridRow row in grid.Rows)
                {
                    row.ApplyStyle(cellStyle);
                    for (int i = 0; i < row.Cells.Count; i++)
                    {
                        row.Cells[i].Style.Borders.Top = new PdfPen(new PdfColor(217, 217, 217), 0.70f);

                        PdfGridCell cell = row.Cells[i];
                        if (i == 1)
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                        }
                        else if (i == 0)
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                        }
                        else if (i == 2)
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                        }
                        else if (i == 3)
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                        }
                        else
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);
                        }


                        if (i > 2)
                        {
                            float val = float.MinValue;
                            float.TryParse(cell.Value.ToString(), out val);
                            //   cell.Value = val.ToString("C");
                        }
                    }


                }


                if (columncount == 4)
                {
                    grid.Columns[0].Width = (page.Size.Width / columncount) + 20;
                    grid.Columns[1].Width = (page.Size.Width / columncount) - 40;
                    grid.Columns[2].Width = (page.Size.Width / columncount) + 20;
                    grid.Columns[3].Width = (page.Size.Width / columncount) - 40;
                }
                else if (columncount == 2)
                {
                    grid.Columns[0].Width = (page.Size.Width / columncount) + 40;
                    grid.Columns[1].Width = (page.Size.Width / columncount) - 40;
                }


                grid.Style.CellPadding.Left = 10F;

                PdfGridLayoutFormat layoutFormat = new PdfGridLayoutFormat();
                layoutFormat.Layout = PdfLayoutType.Paginate;


                PdfGridLayoutResult gridResult = grid.Draw(page, new RectangleF(new PointF(0, result.Bounds.Bottom + 20), new SizeF(graphics.ClientSize.Width, graphics.ClientSize.Height - 100)), layoutFormat);
                float pos = 0.0f;
                for (int i = 0; i < grid.Columns.Count - 1; i++)
                    pos += grid.Columns[i].Width;

                PdfFont font = new PdfStandardFont(PdfFontFamily.TimesRoman, 14f);

                string Note = "Note :\n";
                string ReceiptNotes = string.Empty;
                ReceiptNotes = ds.Tables[4].Rows[0]["ReceiptNotes"].ToString() == "" ? "-" : ds.Tables[4].Rows[0]["ReceiptNotes"].ToString();
                if (ReceiptNotes != "")
                {
                    ReceiptNotes = ReceiptNotes.Replace("|", ",\n");
                }
                //  gridResult.Page.Graphics.DrawString("Total Due", font, new PdfSolidBrush(new PdfColor(126, 151, 173)), new RectangleF(new PointF(pos + 60, gridResult.Bounds.Bottom + 20), new SizeF(grid.Columns[k].Width - pos, 20)), new PdfStringFormat(PdfTextAlignment.Right));
                PdfLayoutResult result1;
                // gridResult.Page.Graphics.DrawString(Note + ReceiptNotes, font, new PdfSolidBrush(new PdfColor(126, 151, 173)), new RectangleF(new PointF(10, gridResult.Bounds.Bottom + 20), new SizeF(graphics.ClientSize.Width / 2, 200)), new PdfStringFormat(PdfTextAlignment.Left));
                result1 = CreateTextElementNote(page, Note + ReceiptNotes, 10, gridResult.Bounds.Bottom + 20, 10f, PdfBrushes.Black, gridResult);

                //gridResult.Page.Graphics.DrawString("For "+ds.Tables[4].Rows[0]["SocietyName"].ToString(), new PdfStandardFont(PdfFontFamily.TimesRoman, 12), new PdfSolidBrush(new PdfColor(89, 89, 93)), new PointF(graphics.ClientSize.Width - 140, gridResult.Bounds.Bottom + 50));
                result1 = CreateTextElement(page, "For " + ds.Tables[4].Rows[0]["SocietyName"].ToString(), (graphics.ClientSize.Width / 2) + 40, result1.Bounds.Bottom + 5, 10f, PdfBrushes.Black, gridResult);

                //  pos += grid.Columns[1].Width;


                string secretorySign;
                if (ds.Tables[4].Rows[0]["Secretorysign"].ToString() != "" && File.Exists(HttpContext.Current.Server.MapPath("../" + ds.Tables[4].Rows[0]["Secretorysign"].ToString())) == true)
                {
                    secretorySign = HttpContext.Current.Server.MapPath("../" + ds.Tables[4].Rows[0]["Secretorysign"].ToString());

                }
                else
                {
                    secretorySign = secretorySign = HttpContext.Current.Server.MapPath("~/Images/secretorysign.png");
                }



                //  gridResult.Page.Graphics.DrawImage(   s       , font, new PdfSolidBrush(new PdfColor(131, 130, 136)), new RectangleF(new PointF(pos + 110, gridResult.Bounds.Bottom + 20), new SizeF(grid.Columns[1].Width - pos, 20)), new PdfStringFormat(PdfTextAlignment.Right));

                // SizeF imageSize = new SizeF(140F, 45f);
                // //Locating the logo on the right corner of the Drawing Surface
                PointF imageLocation = new PointF(graphics.ClientSize.Width - 140, gridResult.Bounds.Bottom + 80);

                // PdfImage img = new PdfBitmap(ResolveApplicationDataPath("logo.png", true));
                PdfImage img = new PdfBitmap(secretorySign);
                // gridResult.Page.Graphics.DrawImage(img, imageLocation, imageSize);

                result1 = DrawimageElement(page, secretorySign, (graphics.ClientSize.Width / 2) + 40, result1.Bounds.Bottom + 5, 10f, PdfBrushes.Black, gridResult);

                result1 = CreateTextElement(page, "Manager/Secretary/Treasurer/Chairman", (graphics.ClientSize.Width / 2) + 40, result1.Bounds.Bottom + 5, 10f, PdfBrushes.Black, gridResult);

            }


            //  gridResult.Page.Graphics.DrawString(total.ToString("C"), font, new PdfSolidBrush(new PdfColor(131, 130, 136)), new RectangleF(new PointF(pos, gridResult.Bounds.Bottom + 20), new SizeF(grid.Columns[4].Width - pos, 20)), new PdfStringFormat(PdfTextAlignment.Right));

            return result;
        }

        private DataTable GenerateFlatMonthlyFee(DataSet ds)
        {
            throw new NotImplementedException();
        }

        #region Generate Datatable

        public DataTable GenerateDatasetToDatatable(DataSet ds, string Maintenancecategory)
        {
            DataTable dt = new DataTable();

            string electricity = string.Empty, water = string.Empty, insurance = string.Empty, Security = string.Empty, HousekeepingSalary = string.Empty, ManagerSalary = string.Empty, Stationary = string.Empty, Dgset = string.Empty, GymInstructor = string.Empty, CommunityHall = string.Empty, SupervisorSalary = string.Empty, TenantMaintenance = string.Empty, MainPerflat = string.Empty, OtherCharges = string.Empty, Total = string.Empty, Interest = string.Empty, NetAmount = string.Empty;
            if (Maintenancecategory == "FlatMonthlyFee" || Maintenancecategory == "LumpsumFee")
            {
                dt.Columns.Add("Payment Type");
                dt.Columns.Add("Charges");
                dt.Columns.Add("Payment Type ");
                dt.Columns.Add("Charges ");

                electricity = ds.Tables[2].Rows[0]["ElectricityCharges"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["ElectricityCharges"].ToString();
                water = ds.Tables[2].Rows[0]["WaterCharges"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["WaterCharges"].ToString();
                insurance = ds.Tables[2].Rows[0]["InsuranceCharges"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["InsuranceCharges"].ToString();
                Security = ds.Tables[2].Rows[0]["SecuritySalary"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["SecuritySalary"].ToString();
                HousekeepingSalary = ds.Tables[2].Rows[0]["HousekeepingSalary"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["HousekeepingSalary"].ToString();
                ManagerSalary = ds.Tables[2].Rows[0]["ManagerSalary"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["ManagerSalary"].ToString();
                Stationary = ds.Tables[2].Rows[0]["Stationary"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["Stationary"].ToString();
                Dgset = ds.Tables[2].Rows[0]["DgSet"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["DgSet"].ToString();
                GymInstructor = ds.Tables[2].Rows[0]["GymInstructor"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["GymInstructor"].ToString();
                CommunityHall = ds.Tables[2].Rows[0]["CommunityHall"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["CommunityHall"].ToString();
                SupervisorSalary = ds.Tables[2].Rows[0]["SupervisorSalary"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["SupervisorSalary"].ToString();
                TenantMaintenance = ds.Tables[2].Rows[0]["TenantMaintenance"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["TenantMaintenance"].ToString();
                MainPerflat = ds.Tables[2].Rows[0]["MaintenancePerFlat"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["MaintenancePerFlat"].ToString();
                OtherCharges = ds.Tables[2].Rows[0]["OtherCharges"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["OtherCharges"].ToString();
                Total = ds.Tables[2].Rows[0]["TotalMaintenanceSum"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["TotalMaintenanceSum"].ToString();
                Interest = Convert.ToString(ds.Tables[4].Rows[0]["InterestRate"]) == "0" ? "0" : ds.Tables[4].Rows[0]["InterestRate"].ToString();
                if (Maintenancecategory == "FlatMonthlyFee")
                {
                    NetAmount = ds.Tables[2].Rows[0]["NetAmount"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["NetAmount"].ToString();
                }
                else
                {
                    NetAmount = ds.Tables[2].Rows[0]["PaidAmount"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["PaidAmount"].ToString();
                }

                dt.Rows.Add("Electricity", electricity, "Water", water);
                dt.Rows.Add("insurance", insurance, "Security", Security);
                dt.Rows.Add("Housekeeping Salary", HousekeepingSalary, "Manager Salary", ManagerSalary);
                dt.Rows.Add("Stationary ", Stationary, "DgSet ", Dgset);
                dt.Rows.Add("Gym Instructor ", GymInstructor, "Community Hall ", CommunityHall);
                dt.Rows.Add("Supervisor Salary", SupervisorSalary, "Non Occupency Charges", TenantMaintenance);
                dt.Rows.Add("", "", "Other ", OtherCharges);
                dt.Rows.Add("", "", "Total ", Total);
                dt.Rows.Add("", "-", "Maintenance PerFlat(Total/Number OF Flats) ", MainPerflat);
                dt.Rows.Add("", "-", "Interest(" + "" + "%)", Interest);
                dt.Rows.Add("", "-", "NetAmount", NetAmount);
            }
            else if (Maintenancecategory == "PerSquareFeetRate")
            {
                // OtherCharges = ds.Tables[1].Rows[0]["OtherCharges"].ToString() == "" ? "-" : ds.Tables[1].Rows[0]["OtherCharges"].ToString();
                Interest = Convert.ToString(ds.Tables[4].Rows[0]["InterestRate"]) == "0" ? "0" : ds.Tables[4].Rows[0]["InterestRate"].ToString();
                NetAmount = ds.Tables[2].Rows[0]["PaidAmount"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["PaidAmount"].ToString();
                dt.Columns.Add("Payment Type");
                dt.Columns.Add("Charges");

                long Amount = Int32.Parse(ds.Tables[2].Rows[0]["PerSquareFeetRate"].ToString()) * Int32.Parse(ds.Tables[1].Rows[0]["TotalArea"].ToString());

                dt.Rows.Add("Per SqFeet Rate", Int32.Parse(ds.Tables[2].Rows[0]["PerSquareFeetRate"].ToString()));
                dt.Rows.Add("Total Area", Int32.Parse(ds.Tables[1].Rows[0]["TotalArea"].ToString()));
                dt.Rows.Add("Amount(Per SqFeet Rate x Total Area)", Amount);
                //dt.Rows.Add("+ Other Charges", OtherCharges);
                dt.Rows.Add("Interest(" + "" + "%)", Interest);
                dt.Rows.Add("Paid Amount", NetAmount);
            }
            else if (Maintenancecategory == "PartialFlatRate")
            {
                // OtherCharges = ds.Tables[1].Rows[0]["OtherCharges"].ToString() == "" ? "-" : ds.Tables[1].Rows[0]["OtherCharges"].ToString();
                NetAmount = ds.Tables[2].Rows[0]["PaidAmount"].ToString() == "" ? "-" : ds.Tables[2].Rows[0]["PaidAmount"].ToString();
                Interest = Convert.ToString(ds.Tables[4].Rows[0]["InterestRate"]) == "0" ? "0" : ds.Tables[4].Rows[0]["InterestRate"].ToString();
                dt.Columns.Add("Payment Type");
                dt.Columns.Add("Charges");

                long Amount = Int32.Parse(ds.Tables[2].Rows[0]["PerSquareFeetRate"].ToString()) * Int32.Parse(ds.Tables[1].Rows[0]["TotalArea"].ToString());

                dt.Rows.Add("Fixed Sqft", Int32.Parse(ds.Tables[2].Rows[0]["FixedSqft"].ToString()));
                dt.Rows.Add("FixedRate", Int32.Parse(ds.Tables[2].Rows[0]["FixedRate"].ToString()));
                dt.Rows.Add("Additional Sq. ft. Rate", Int32.Parse(ds.Tables[2].Rows[0]["AdditionalSqftRate"].ToString()));
                dt.Rows.Add("Additional Sq. ft.", Int32.Parse(ds.Tables[2].Rows[0]["AdditionalSqft"].ToString()));

                dt.Rows.Add("Amount(Per SqFeet Rate x Total Area)", Amount);
                //   dt.Rows.Add("+ Other Charges", OtherCharges);
                dt.Rows.Add("Interest(" + "" + "%)", Interest);
                dt.Rows.Add("Paid Amount", NetAmount);
            }
            else if (Maintenancecategory == "MixedApproach")
            {

            }



            return dt;
        }

        #endregion

        #region Create Watermark on Pdf
        public void WaterMarkOnPDF(PdfDocument doc, string waterMarkText, string imagepath)
        {
            if (waterMarkText != "")
            {
                PdfFont font = new PdfStandardFont(PdfFontFamily.Helvetica, 36f);
                foreach (PdfPage page in doc.Pages)
                {
                    PdfGraphics g = page.Graphics;
                    PdfGraphicsState state = g.Save();
                    g.SetTransparency(0.95f);
                    g.RotateTransform(-40);
                    g.DrawString(waterMarkText, font, PdfPens.Red, PdfBrushes.Red, new PointF(-150, 450));
                }
            }
            else if (imagepath != "")
            {
                foreach (PdfPage page in doc.Pages)
                {
                    PdfGraphics g = page.Graphics;
                    SizeF imageSize = new SizeF(190F, 200F);

                    PdfGraphicsState state = g.Save();
                    g.SetTransparency(0.95f);
                    g.RotateTransform(-40);
                    PdfImage image = new PdfBitmap(imagepath);
                    PointF imageLocation = new PointF(-150, 450);
                    g.DrawImage(image, imageLocation, imageSize);

                }
            }
        }

        #endregion

        #region Send SMS
        public string SendSms(string username, string password, string SenderName, string priority, string MessageType, string number, string Message)
        {
            string MessageID, Output;
            var cli = new System.Net.WebClient();

            var smsbalance = @"http://bhashsms.com/api/checkbalance.php?user={0}&pass={1}";

            //Get balance sms Count
            string count = cli.DownloadString(string.Format(smsbalance, username, password));

            if (Int32.Parse(count) > 0)
            {
                var format = @"http://bhashsms.com/api/sendmsg.php?user={0}&pass={1}&sender={2}&priority={3}&stype={4}&phone={5}&text={6}";
                MessageID = cli.DownloadString(string.Format(format, username, password, SenderName, priority, MessageType, number, Message));
                //Get Status of Sent Sms = sent-still pending but not DELIVRD,  DELIVRD-Successfully sent
                //if (MessageID != "")
                //{
                //    var sendingreport = @"http://bhashsms.com/api/recdlr.php?user={0}&msgid={1}&phone={2}&msgtype={3}";
                //    string status = cli.DownloadString(string.Format(sendingreport, username, MessageID, number, MessageType));
                //}
                MessageID = MessageID.Replace("\r\n", "").TrimEnd().Replace(" ", ",").ToString();
                string[] abc = MessageID.Split(',');


                Output = "Message Sent Successfully";
            }
            else
            {
                Output = "We can not sent mail because of technical Reason, please contact Admin";
            }
            return Output;

        }
        #endregion


        #region Delete all file in Folder
        public static void DeleteAllFile(string path)
        {
            string[] filePaths = Directory.GetFiles(path);
            foreach (string filePath in filePaths)
            {
                File.Delete(filePath);
            }
        }
        #endregion

        #region GetExcel Connection
        public static string GetExcelConnection(string Extension)
        {
            string conStr = "";

            switch (Extension)
            {
                case ".xls": //Excel 97-03
                    conStr = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07
                    conStr = ConfigurationManager.ConnectionStrings["Excel07ConString"].ConnectionString;
                    break;
            }

            return conStr;

        }
        #endregion


        public static OleDbConnection GetExcelOledbConnection(string filePath)
        {
            return new System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties=\"Excel 12.0;HDR=YES;\"");
        }

        public static string GenerateUniqueKey()
        {
            string uCode = DateTime.Now.ToString("yyyyMMddHHmmssfffffff");
            string uniqueKey = "A" + "_" + uCode;
            return uniqueKey;
        }

        #region Convert Dataset To Datatable
        public static DataTable GenerateTotalPendingExpense(DataSet ds)
        {
            DataTable dt = new DataTable();

            dt = ds.Tables[1];



            int lR = dt.Rows.Count - 1;
            dt.Rows.Add("", "", float.Parse(ds.Tables[0].Rows[0]["Amount"].ToString()), "", 0, 0);
            dt.Rows.Add(ds.Tables[0].Rows[0]["MaintenanceId"].ToString(), ds.Tables[0].Rows[0]["PropertyType"].ToString(), 0.00, 0.00, 0.00, 0);


            return dt;
        }
        #endregion







        public PdfLayoutResult BasicBillInfo(PdfLayoutResult result, PdfGraphics graphics, PdfPage page, DataSet ds, string GenerateTable, int columncount, int k)
        {
            PdfGrid grid = new PdfGrid();

            DataTable dt = (DataTable)GenerateReceiptPaidAmount(ds);
            grid.DataSource = dt;

            PdfGridCellStyle cellStyle = new PdfGridCellStyle();
            cellStyle.Borders.All = PdfPens.White;
            PdfGridRow header = grid.Headers[0];

            PdfGridCellStyle headerStyle = new PdfGridCellStyle();
            headerStyle.Borders.All = new PdfPen(new PdfColor(255, 255, 255));
            headerStyle.BackgroundBrush = new PdfSolidBrush(new PdfColor(255, 255, 255));
            headerStyle.TextBrush = PdfBrushes.White;
            headerStyle.Font = new PdfStandardFont(PdfFontFamily.TimesRoman, 14f, PdfFontStyle.Regular);

            for (int i = 0; i < header.Cells.Count; i++)
            {
                if (i == 0 || i == 1 || i == 2 || i == 3)
                    header.Cells[i].StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                else
                    header.Cells[i].StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);
            }

            header.ApplyStyle(headerStyle);
            cellStyle.Borders.Bottom = new PdfPen(new PdfColor(217, 217, 217), 0.70f);
            cellStyle.Font = new PdfStandardFont(PdfFontFamily.TimesRoman, 12f);
            cellStyle.TextBrush = new PdfSolidBrush(new PdfColor(0, 0, 0));
            cellStyle.Borders.Left = new PdfPen(new PdfColor(217, 217, 217), 0.70f);
            cellStyle.Borders.Right = new PdfPen(new PdfColor(217, 217, 217), 0.70f);
            foreach (PdfGridRow row in grid.Rows)
            {
                row.ApplyStyle(cellStyle);
                for (int i = 0; i < row.Cells.Count; i++)
                {
                    row.Cells[i].Style.Borders.Top = new PdfPen(new PdfColor(217, 217, 217), 0.70f);

                    PdfGridCell cell = row.Cells[i];
                    if (i == 1)
                    {
                        cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                    }
                    else if (i == 0)
                    {
                        cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                    }
                    else if (i == 2)
                    {
                        cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);
                        row.Cells[2].ColumnSpan = 2;

                    }
                    else if (i == 3)
                    {
                        cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                    }
                    else
                    {
                        cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);
                    }


                    if (i > 2)
                    {
                        float val = float.MinValue;
                        float.TryParse(cell.Value.ToString(), out val);
                        //   cell.Value = val.ToString("C");
                    }
                }


            }

            if (columncount == 4)
            {
                grid.Columns[0].Width = (page.Size.Width / columncount) + 20;
                grid.Columns[1].Width = (page.Size.Width / columncount) - 40;
                grid.Columns[2].Width = (page.Size.Width / columncount) + 20;
                grid.Columns[3].Width = (page.Size.Width / columncount) - 40;
            }
            else if (columncount == 2)
            {
                grid.Columns[0].Width = (page.Size.Width / columncount) - 35;
                grid.Columns[1].Width = (page.Size.Width / columncount) + 10;
            }
            grid.Style.CellPadding.Left = 10F;

            PdfGridLayoutFormat layoutFormat = new PdfGridLayoutFormat();
            layoutFormat.Layout = PdfLayoutType.Paginate;


            float pos = 0.0f;
            grid.Rows[2].Cells[0].ColumnSpan = 2;
            PdfGridLayoutResult gridResult = grid.Draw(page, new RectangleF(new PointF(0, result.Bounds.Bottom + 10), new SizeF(graphics.ClientSize.Width, graphics.ClientSize.Height - 100)), layoutFormat);
            return gridResult;
        }

        private DataTable GenerateReceiptPaidAmount(DataSet ds)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("", typeof(String));
            dt.Columns.Add("", typeof(String));

            string srNo = Convert.ToString(ds.Tables[2].Rows[0]["Day"]) + "-" + Convert.ToString(ds.Tables[2].Rows[0]["MonthName"]);
            string BillingForPeriod = Convert.ToString(ds.Tables[2].Rows[0]["MonthName"]) + "-" + Convert.ToString(ds.Tables[2].Rows[0]["Year"]);
            string FlatNo = Convert.ToString(ds.Tables[1].Rows[0]["FlatNumber"]);
            string Ownername = Convert.ToString(ds.Tables[1].Rows[0]["OwnerName1"]);
            string BillDate = Convert.ToString(ds.Tables[1].Rows[0]["BillDate"]) + "-" + BillingForPeriod;
            dt.Rows.Add("SR.NO : " + srNo, "BILLING FOR THE PERIOD :" + BillingForPeriod);
            dt.Rows.Add("FLAT NO :" + FlatNo, "BILL DATE: " + BillDate);
            dt.Rows.Add("NAME:" + Ownername, "");

            return dt;

        }

        public PdfLayoutResult InsertAmountDetail(PdfLayoutResult result, PdfGraphics graphics, PdfPage page, DataSet ds, string GenerateTable, int columncount, int k)
        {
            PdfGrid grid = new PdfGrid();

            if (GenerateTable == "Yes")
            {


                DataTable dt = (DataTable)GenerateInsertAmountDetail(ds);
                grid.DataSource = dt;




                PdfGridCellStyle cellStyle = new PdfGridCellStyle();
                cellStyle.Borders.All = PdfPens.White;
                PdfGridRow header = grid.Headers[0];

                PdfGridCellStyle headerStyle = new PdfGridCellStyle();
                headerStyle.Borders.All = new PdfPen(new PdfColor(126, 151, 173));
                headerStyle.BackgroundBrush = new PdfSolidBrush(new PdfColor(107, 83, 83));
                headerStyle.TextBrush = PdfBrushes.White;
                headerStyle.Font = new PdfStandardFont(PdfFontFamily.TimesRoman, 14f, PdfFontStyle.Regular);

                for (int i = 0; i < header.Cells.Count; i++)
                {
                    if (i == 0 || i == 1 || i == 2 || i == 3)
                        header.Cells[i].StringFormat = new PdfStringFormat(PdfTextAlignment.Center, PdfVerticalAlignment.Middle);
                    else
                        header.Cells[i].StringFormat = new PdfStringFormat(PdfTextAlignment.Center, PdfVerticalAlignment.Middle);
                }

                header.ApplyStyle(headerStyle);
                cellStyle.Borders.Bottom = new PdfPen(new PdfColor(217, 217, 217), 0.70f);
                cellStyle.Font = new PdfStandardFont(PdfFontFamily.TimesRoman, 12f);
                cellStyle.TextBrush = new PdfSolidBrush(new PdfColor(0, 0, 0));
                cellStyle.Borders.Left = new PdfPen(new PdfColor(217, 217, 217), 0.70f);
                cellStyle.Borders.Right = new PdfPen(new PdfColor(217, 217, 217), 0.70f);

                //



                foreach (PdfGridRow row in grid.Rows)
                {
                    row.ApplyStyle(cellStyle);



                    for (int i = 0; i < row.Cells.Count; i++)
                    {
                        row.Cells[i].Style.Borders.Top = new PdfPen(new PdfColor(217, 217, 217), 0.70f);

                        PdfGridCell cell = row.Cells[i];

                        if (i == 6)
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);
                        }

                        else if (i == 1)
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                        }
                        else if (i == 0)
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Center, PdfVerticalAlignment.Middle);
                        }
                        else if (i == 2)
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Center, PdfVerticalAlignment.Middle);

                        }
                        else if (i == 3)
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Left, PdfVerticalAlignment.Middle);
                        }
                        else
                        {
                            cell.StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);
                        }


                        if (i > 2)
                        {
                            float val = float.MinValue;
                            float.TryParse(cell.Value.ToString(), out val);
                            //   cell.Value = val.ToString("C");
                        }
                    }

                }

                Font ffont = new Font("TimesRoman", 11, FontStyle.Bold);

                //create a new pdf font
                PdfFont Rowfont = new PdfTrueTypeFont(ffont, true);
                PdfGridCellStyle style = new PdfGridCellStyle();
                style.Borders.Left = new PdfPen(new PdfColor(217, 217, 217), 0.0f);
                style.Borders.Right = new PdfPen(new PdfColor(217, 217, 217), 0.0f);
                style.Borders.Top = new PdfPen(new PdfColor(217, 217, 217), 0.0f);
                style.Borders.Bottom = new PdfPen(new PdfColor(217, 217, 217), 0.0f);
                style.Font = Rowfont;


                grid.Rows[4].Cells[1].StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);
                grid.Rows[4].Cells[1].Style = style;
                grid.Rows[8].Cells[1].Style = style;
                grid.Rows[8].Cells[1].StringFormat = new PdfStringFormat(PdfTextAlignment.Right, PdfVerticalAlignment.Middle);


                if (columncount == 4)
                {
                    grid.Columns[0].Width = (page.Size.Width / columncount) + 20;
                    grid.Columns[1].Width = (page.Size.Width / columncount) - 40;
                    grid.Columns[2].Width = (page.Size.Width / columncount) + 20;
                    grid.Columns[3].Width = (page.Size.Width / columncount) - 40;
                }
                else if (columncount == 2)
                {
                    grid.Columns[0].Width = (page.Size.Width / columncount) + 40;
                    grid.Columns[1].Width = (page.Size.Width / columncount) - 40;
                }
                else if (columncount == 3)
                {
                    grid.Columns[0].Width = 40;
                    grid.Columns[1].Width = (page.Size.Width / columncount) + 110;
                    grid.Columns[2].Width = (page.Size.Width / columncount) - 40;

                }

                grid.Style.CellPadding.Left = 10F;

                PdfGridLayoutFormat layoutFormat = new PdfGridLayoutFormat();
                layoutFormat.Layout = PdfLayoutType.Paginate;


                PdfGridLayoutResult gridResult = grid.Draw(page, new RectangleF(new PointF(0, result.Bounds.Bottom + 20), new SizeF(graphics.ClientSize.Width, graphics.ClientSize.Height - 100)), layoutFormat);
                float pos = 0.0f;
                for (int i = 0; i < grid.Columns.Count - 1; i++)
                    pos += grid.Columns[i].Width;

                PdfFont font = new PdfStandardFont(PdfFontFamily.TimesRoman, 14f);

                string Note = "Note :\n";
                string ReceiptNotes = string.Empty;

                ReceiptNotes = ds.Tables[4].Rows[0]["ReceiptNotes"].ToString() == "" ? "-" : ds.Tables[4].Rows[0]["ReceiptNotes"].ToString();

                if (ReceiptNotes != "")
                {
                    ReceiptNotes = ReceiptNotes.Replace("|", ",\n");
                }


                //  gridResult.Page.Graphics.DrawString("Total Due", font, new PdfSolidBrush(new PdfColor(126, 151, 173)), new RectangleF(new PointF(pos + 60, gridResult.Bounds.Bottom + 20), new SizeF(grid.Columns[k].Width - pos, 20)), new PdfStringFormat(PdfTextAlignment.Right));
                PdfLayoutResult result1;
                // gridResult.Page.Graphics.DrawString(Note + ReceiptNotes, font, new PdfSolidBrush(new PdfColor(126, 151, 173)), new RectangleF(new PointF(10, gridResult.Bounds.Bottom + 20), new SizeF(graphics.ClientSize.Width / 2, 200)), new PdfStringFormat(PdfTextAlignment.Left));
                result1 = CreateTextElementNote(page, Note + ReceiptNotes, 10, gridResult.Bounds.Bottom + 20, 10f, PdfBrushes.Black, gridResult);

                //gridResult.Page.Graphics.DrawString("For "+ds.Tables[4].Rows[0]["SocietyName"].ToString(), new PdfStandardFont(PdfFontFamily.TimesRoman, 12), new PdfSolidBrush(new PdfColor(89, 89, 93)), new PointF(graphics.ClientSize.Width - 140, gridResult.Bounds.Bottom + 50));
                result1 = CreateTextElement(page, "For " + ds.Tables[4].Rows[0]["SocietyName"].ToString(), (graphics.ClientSize.Width / 2) + 40, result1.Bounds.Bottom + 5, 10f, PdfBrushes.Black, gridResult);

                //  pos += grid.Columns[1].Width;


                string secretorySign;
                if (ds.Tables[4].Rows[0]["Secretorysign"].ToString() != "" && File.Exists(HttpContext.Current.Server.MapPath("../" + ds.Tables[4].Rows[0]["Secretorysign"].ToString())) == true)
                {
                    secretorySign = HttpContext.Current.Server.MapPath("../" + ds.Tables[4].Rows[0]["Secretorysign"].ToString());

                }
                else
                {
                    secretorySign = secretorySign = HttpContext.Current.Server.MapPath("~/Images/secretorysign.png");
                }



                //  gridResult.Page.Graphics.DrawImage(   s       , font, new PdfSolidBrush(new PdfColor(131, 130, 136)), new RectangleF(new PointF(pos + 110, gridResult.Bounds.Bottom + 20), new SizeF(grid.Columns[1].Width - pos, 20)), new PdfStringFormat(PdfTextAlignment.Right));

                // SizeF imageSize = new SizeF(140F, 45f);
                // //Locating the logo on the right corner of the Drawing Surface
                PointF imageLocation = new PointF(graphics.ClientSize.Width - 140, gridResult.Bounds.Bottom + 80);

                // PdfImage img = new PdfBitmap(ResolveApplicationDataPath("logo.png", true));
                PdfImage img = new PdfBitmap(secretorySign);
                // gridResult.Page.Graphics.DrawImage(img, imageLocation, imageSize);

                result1 = DrawimageElement(page, secretorySign, (graphics.ClientSize.Width / 2) + 40, result1.Bounds.Bottom + 5, 10f, PdfBrushes.Black, gridResult);

                result1 = CreateTextElement(page, "Manager/Secretary/Treasurer/Chairman", (graphics.ClientSize.Width / 2) + 40, result1.Bounds.Bottom + 5, 10f, PdfBrushes.Black, gridResult);

            }

            //  gridResult.Page.Graphics.DrawString(total.ToString("C"), font, new PdfSolidBrush(new PdfColor(131, 130, 136)), new RectangleF(new PointF(pos, gridResult.Bounds.Bottom + 20), new SizeF(grid.Columns[4].Width - pos, 20)), new PdfStringFormat(PdfTextAlignment.Right));
            return result;
        }

        private void WaterMarkOnPDF(PdfDocument doc, string waterMarkText)
        {
            PdfFont font = new PdfStandardFont(PdfFontFamily.TimesRoman, 36f);
            foreach (PdfPage page in doc.Pages)
            {
                PdfGraphics g = page.Graphics;
                PdfGraphicsState state = g.Save();
                g.SetTransparency(0.25f);
                g.RotateTransform(-40);
                g.DrawString(waterMarkText, font, PdfPens.Red, PdfBrushes.Red, new PointF(-150, 450));
            }

        }
        public PdfLayoutResult CreateTextElement(PdfPage page, string title, float xPosition, float bottomValue, float fontSize, PdfBrush textbrush, PdfGridLayoutResult gridResult)
        {

            PdfFont font = new PdfStandardFont(PdfFontFamily.TimesRoman, fontSize);

            float prevBottomValue = bottomValue;

            PdfBrush brush = textbrush;

            PdfTextElement richTextElement = new PdfTextElement(string.Format("{0}", title), font, brush);



            // Formatting Layout

            PdfMetafileLayoutFormat format = new PdfMetafileLayoutFormat();

            format.Layout = PdfLayoutType.Paginate;

            //Drawing String

            PdfLayoutResult result = richTextElement.Draw(page, new RectangleF(xPosition, prevBottomValue, page.GetClientSize().Width, 0), format);


            return result;

        }

        public PdfLayoutResult CreateTextElementNote(PdfPage page, string title, float xPosition, float bottomValue, float fontSize, PdfBrush textbrush, PdfGridLayoutResult gridResult)
        {

            PdfFont font = new PdfStandardFont(PdfFontFamily.TimesRoman, 10, PdfFontStyle.Italic);

            float prevBottomValue = bottomValue;

            PdfBrush brush = textbrush;

            PdfTextElement richTextElement = new PdfTextElement(string.Format("{0}", title), font, brush);



            // Formatting Layout

            PdfMetafileLayoutFormat format = new PdfMetafileLayoutFormat();

            format.Layout = PdfLayoutType.Paginate;

            //Drawing String

            PdfLayoutResult result = richTextElement.Draw(page, new RectangleF(xPosition, prevBottomValue, page.GetClientSize().Width, 0), format);


            return result;

        }

        public PdfLayoutResult DrawimageElement(PdfPage page, string img, float xPosition, float bottomValue, float fontSize, PdfBrush textbrush, PdfGridLayoutResult gridResult)
        {

            PdfImage image = new PdfBitmap(img);

            PdfLayoutFormat format = new PdfLayoutFormat();
            format.Layout = PdfLayoutType.Paginate;

            PointF imageLocation = new PointF(xPosition, bottomValue);
            SizeF imageSize = new SizeF(140F, 45f);
            // PdfImage img = new PdfBitmap(ResolveApplicationDataPath("logo.png", true));
            PointF location = new PointF(xPosition, bottomValue);

            RectangleF rect = new RectangleF(location, imageSize);






            PdfLayoutResult result = image.Draw(page, rect, format);

            return result;

        }

        private DataTable GenerateInsertAmountDetail(DataSet ds)
        {
            DataTable dt = new DataTable();

            float MonthlyCharge = string.IsNullOrEmpty(ds.Tables[1].Rows[0]["AmountBalance"].ToString()) == true ? 0 : float.Parse(ds.Tables[1].Rows[0]["AmountBalance"].ToString());
            float NonOccupencyCharge = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["TenantMaintenance"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["TenantMaintenance"].ToString());
            float NOCChargesforNonOccupants = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["NonChargesNonOcc"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["NonChargesNonOcc"].ToString());
            float SinkingFund = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["SinkingFund"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["SinkingFund"].ToString());
            float TOTALBILLINGMONTH = MonthlyCharge + NonOccupencyCharge + NOCChargesforNonOccupants + SinkingFund;
            float DuePayment = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["OutstandingAmount"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["OutstandingAmount"].ToString()); ;
            float InterestonDefaulted = 0;//float.Parse(ds.Tables[2].Rows[0]["InterestRate"].ToString())
            float CreditAmountBalance = string.IsNullOrEmpty(ds.Tables[2].Rows[0]["CreditAmountBalance"].ToString()) == true ? 0 : float.Parse(ds.Tables[2].Rows[0]["CreditAmountBalance"].ToString());
            float TotalPayment = TOTALBILLINGMONTH + DuePayment + CreditAmountBalance;

            dt.Columns.Add("Sr No");
            dt.Columns.Add("Particulars");
            dt.Columns.Add("Amount");

            dt.Rows.Add(1, "Monthly Maintenance Charges", MonthlyCharge);
            dt.Rows.Add(2, "Non Occupancy Charges", NonOccupencyCharge);
            dt.Rows.Add(3, "NOC Charges for Non Occupants", NOCChargesforNonOccupants);
            dt.Rows.Add(4, "Sinking Fund", SinkingFund);
            dt.Rows.Add("", "Total Of Billing Month", TOTALBILLINGMONTH);
            dt.Rows.Add(5, "Due Payment of Previous Bill / Previous Dues (After Last Payment)", DuePayment);
            dt.Rows.Add(6, "Interest on Defaulted Dues", InterestonDefaulted);
            dt.Rows.Add(7, "Credit Amount Balance Towards Society (Less Adjustment)", CreditAmountBalance);
            dt.Rows.Add("", "Total Payment", TotalPayment);

            return dt;
        }



        public string HtmlGenerateReceipt(DataSet ds)
        {

            string logo=string.Empty, Address, genetable = string.Empty;

            StringBuilder receipt = new StringBuilder();

            if (ds.Tables[4].Rows[0]["Logo"].ToString() != "" && File.Exists(HttpContext.Current.Server.MapPath("../" + ds.Tables[4].Rows[0]["Logo"].ToString())) == true)
            {
                logo = HttpContext.Current.Server.MapPath("../" + ds.Tables[4].Rows[0]["Logo"].ToString());
            }
            else
            {
                // logo = HttpContext.Current.Server.MapPath("../" + "Images/logo.png");
                logo = "";
            }
            string SocietyName = ds.Tables[4].Rows[0]["SocietyName"].ToString();
            Address = ds.Tables[4].Rows[0]["SocietyAddress"].ToString();
            if (Address != "")
            {
                Address = Address.Replace(",", ",\n");
            }


            receipt.Append("<table width=\"564\" border=\"0\" style=\"border:#FFFFFF\" bordercolor=\"#FFFFFF\" bgcolor=\"#FFFFFF\">");
            receipt.Append("<tr>");
            receipt.Append("<td bordercolor=\"#FFFFFF\" style=\"border:#FFFFFF\"  bgcolor=\"#FFFFFF\">");
            receipt.Append("<table width=\"564\" border=\"0\">");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"200\" border=\"0\" style=\"color:black; border:#FFFFFF\">");
            if(logo=="" || logo==null)
            {
                receipt.Append("");
            }
            else
            {
                receipt.Append("<img src =\"" + logo + "\"  style=\"margin-top:3px\" class=\"img-responsive\" alt=\"Logo\" />");
               
            }

            receipt.Append("</td>");
            //receipt.Append("<td width=\"102\" border=\"0\" style=\"color:black;style=\"border:#FFFFFF\"></td>");
            receipt.Append("<td width=\"552\" border=\"0\" align=\"right\" style=\"border:#FFFFFF;text-align:right;\" ><p style=\"font-size:17px;color:black;font-weight:bold;\">" + ds.Tables[4].Rows[0]["SocietyName"].ToString() + "</p><p style=\"font-size:15px;color:black;\">" + ds.Tables[4].Rows[0]["SocietyAddress"].ToString() + "</p></td>");
            receipt.Append("</tr>");
            receipt.Append("</table>");
            receipt.Append("");
            receipt.Append("<table width=\"564\" border=\"1\">");
            receipt.Append("<tr>");
            string srNo = Convert.ToString(ds.Tables[1].Rows[0]["FlatNo"]) + "/" + Convert.ToString(ds.Tables[2].Rows[0]["MonthName"]).Substring(0, 3);
            string BillingForPeriod = Convert.ToString(ds.Tables[2].Rows[0]["MonthName"]) + "-" + Convert.ToString(ds.Tables[2].Rows[0]["Year"]);
            string FlatNo = Convert.ToString(ds.Tables[1].Rows[0]["FlatNumber"]);
            string Ownername = Convert.ToString(ds.Tables[1].Rows[0]["OwnerName1"]);
            string BillDate = Convert.ToString(ds.Tables[1].Rows[0]["BillDate"]) + "-" + BillingForPeriod;


            receipt.Append("<td bordercolor=\"#666666\"><div align=\"justify\"><span style=\"color:black;font-weight:bold\" >Sr No : </span>" + srNo + "</div></td>");
            receipt.Append("<td><span class=\"style3\"><span style=\"color:black;font-weight:bold\" >Billing For The Period : </span>" + BillingForPeriod + "</td>");
            receipt.Append("</tr>");
            receipt.Append("<tr bordercolor=\"#666666\">");
            receipt.Append("<td><span style=\"color:black;font-weight:bold\" >Flat No : </span>" + FlatNo + "</td>");
            receipt.Append("<td><span style=\"color:black;font-weight:bold\" >Bill Date : </span> " + BillDate + "</td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td colspan=\"2\"><span style=\"color:black;font-weight:bold\" >Name : </span> " + Ownername + "</td>");
            receipt.Append("  ");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td colspan=\"2\" border=\"0\" bordercolor=\"#FFFFFF\"><span style=\"color:black;font-weight:bold\" >&nbsp;&nbsp;</span></td>");
            receipt.Append("</tr>");

            receipt.Append("</table>");



            receipt.Append("<table width=\"564\" border=\"1\" bordercolor=\"#FFFFFF\">");
            receipt.Append("<tr>");
            receipt.Append("<td nowrap bordercolor=\"#F0F0F0\"  bgcolor=\"#993300\"><h3 align=\"center\" style=\"color:#ffffff;font-size:15px\">Monthly Maintenance Bill</h3></td>");
            receipt.Append("</tr>");
            receipt.Append("</table>");
            receipt.Append("<table width=\"100%\" border=\"1\">");
            receipt.Append("<tr>");
            receipt.Append("<th width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 15px\">Sr No</th>");
            receipt.Append("<th width=\"70%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 15px\">Particulars</th>");
            receipt.Append("<th width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 15px\">Amount</th>");
            receipt.Append("</tr>");

            dynamic MonthlyCharge = ds.Tables[2].Rows[0]["MaintenancePerFlat"].ToString();
            dynamic NonOccupencyCharge = ds.Tables[2].Rows[0]["TenantMaintenance"].ToString();
            dynamic NOCChargesforNonOccupants = ds.Tables[2].Rows[0]["NonChargesNonOcc"].ToString();
            dynamic SinkingFund = ds.Tables[2].Rows[0]["SinkingFund"].ToString();

            dynamic TOTALBILLINGMONTH = 0.00, FMonthlyCharge, FNonOccupencyCharge, FNOCChargesforNonOccupants, FSinkingFund;
            if (MonthlyCharge == "--")
            {

                FMonthlyCharge = string.Format("{0:0.00}", 0);
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + FMonthlyCharge;
                FMonthlyCharge = MonthlyCharge;
            }
            else
            {
                FMonthlyCharge = string.Format("{0:0.00}", float.Parse(MonthlyCharge.ToString()));
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FMonthlyCharge.ToString());
            }
            if (NonOccupencyCharge == "--")
            {
                FNonOccupencyCharge = string.Format("{0:0.00}", 0);
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FNonOccupencyCharge.ToString());
                FNonOccupencyCharge = NonOccupencyCharge;

            }
            else
            {
                FNonOccupencyCharge = string.Format("{0:0.00}", float.Parse(NonOccupencyCharge.ToString()));
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FNonOccupencyCharge.ToString());
            }


            if (NOCChargesforNonOccupants == "--")
            {
                FNOCChargesforNonOccupants = string.Format("{0:0.00}", 0);
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FNOCChargesforNonOccupants.ToString());
                FNOCChargesforNonOccupants = NOCChargesforNonOccupants;
            }
            else
            {
                FNOCChargesforNonOccupants = string.Format("{0:0.00}", float.Parse(NOCChargesforNonOccupants.ToString()));
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FNOCChargesforNonOccupants.ToString());
            }


            if (SinkingFund == "--")
            {
                FSinkingFund = string.Format("{0:0.00}", 0);
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FSinkingFund.ToString());
                FSinkingFund = SinkingFund;
            }
            else
            {
                FSinkingFund = string.Format("{0:0.00}", float.Parse(SinkingFund.ToString()));
                TOTALBILLINGMONTH = TOTALBILLINGMONTH + float.Parse(FSinkingFund.ToString());
            }



            dynamic DuePayment = ds.Tables[2].Rows[0]["OutstandingAmount"].ToString();
            dynamic InterestonDefaulted = "--";//float.Parse(ds.Tables[2].Rows[0]["InterestRate"].ToString())
            dynamic CreditAmountBalance = ds.Tables[2].Rows[0]["CreditAmountBalance"].ToString();

            dynamic TotalPayment = 0.00, FDuePayment, FInterestonDefaulted, FCreditAmountBalance;
            if (DuePayment == "--")
            {
                FDuePayment = string.Format("{0:0.00}", 0);
                TotalPayment = float.Parse(TOTALBILLINGMONTH.ToString()) + float.Parse(FDuePayment.ToString());
                FDuePayment = DuePayment;
            }
            else
            {
                FDuePayment = string.Format("{0:0.00}", float.Parse(DuePayment.ToString()));
                TotalPayment = float.Parse(TOTALBILLINGMONTH.ToString()) + float.Parse(FDuePayment.ToString());
            }

            if (InterestonDefaulted == "--")
            {
                FInterestonDefaulted = string.Format("{0:0.00}", 0);
                TotalPayment = TotalPayment + float.Parse(FInterestonDefaulted.ToString());
                FInterestonDefaulted = InterestonDefaulted;
            }
            else
            {
                FInterestonDefaulted = string.Format("{0:0.00}", float.Parse(InterestonDefaulted.ToString()));
                TotalPayment = TotalPayment + float.Parse(FInterestonDefaulted.ToString());
            }

            if (CreditAmountBalance == "--")
            {
                FCreditAmountBalance = string.Format("{0:0.00}", 0);
                TotalPayment = TotalPayment + float.Parse(FCreditAmountBalance.ToString());
                FCreditAmountBalance = CreditAmountBalance;
            }
            else
            {
                FCreditAmountBalance = string.Format("{0:0.00}", float.Parse(CreditAmountBalance.ToString()));
                TotalPayment = TotalPayment + float.Parse(FCreditAmountBalance.ToString());
            }




            receipt.Append("<tr>");
            receipt.Append("<td  width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >1</span></td>");
            receipt.Append("<td  width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Monthly Maintenance Charges  </span></td>");
            receipt.Append("<td  width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FMonthlyCharge + " </span></td>");
            receipt.Append("</tr>");


            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >2</span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Non Occupancy Charges  </span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FNonOccupencyCharge + " </span></td>");
            receipt.Append("</tr>");


            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >3</span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >NOC Charges for Non Occupants  </span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FNOCChargesforNonOccupants + " </span></td>");
            receipt.Append("</tr>");

            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >4 </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Sinking Fund </span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FSinkingFund + " </span></td>");
            receipt.Append("</tr>");



            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" > </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"  style=\"color:black; text-align: right; font-weight:bold; padding:1px 5px;\"><span>Total Of Billing Month</span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"color:black;text-align:center; padding:1px 5px;\"><span  >" + string.Format("{0:0.00}", string.Format("{0:0.00}", float.Parse(TOTALBILLINGMONTH.ToString()))) + " </span></td>");
            receipt.Append("</tr>");


            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >5  </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Due Payment of Previous Bill / Previous Dues (After Last Payment)</span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FDuePayment + " </span></td>");
            receipt.Append("</tr>");

            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >6  </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Interest on Defaulted Dues</span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FInterestonDefaulted + " </span></td>");
            receipt.Append("</tr>");

            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" >7  </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"><span style=\"color:black; padding:1px 5px;\" >Credit Amount Balance Towards Society (Less Adjustment)</span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + FCreditAmountBalance + " </span></td>");
            receipt.Append("</tr>");

            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" bordercolor=\"#666666\" style=\"text-align: center; padding:1px 5px;\"><span style=\"color:black;;text-align:center\" > </span></td>");
            receipt.Append("<td width=\"70%\" bordercolor=\"#666666\"  style=\"color:black; text-align: right; font-weight:bold; padding:1px 5px;\"><span>Total Payment</span></td>");
            receipt.Append("<td width=\"20%\" bordercolor=\"#666666\" style=\"color:black;text-align:center; padding:1px 5px;\"><span style=\"color:black;text-align:center\" >" + string.Format("{0:0.00}", float.Parse(TotalPayment.ToString())) + " </span></td>");
            receipt.Append("</tr>");


            string Registrationnumber = ds.Tables[4].Rows[0]["RegistrationNumber"].ToString();
            string Notes = ds.Tables[4].Rows[0]["ReceiptNotes"].ToString().Replace("|", "<br/>");

            receipt.Append("</table>");
            receipt.Append("<table width=\"564\" border=\"0\">");
            receipt.Append("<tr>");
            receipt.Append("<td bordercolor=\"#FFFFFF\"  bgcolor=\"#FFFFFF\"><span style=\"color:red;\">Notes:</span></td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td>" + Notes + "</td>");
            receipt.Append("</tr>");
            receipt.Append("</table>");
            receipt.Append("<table bordercolor=\"#FFFFFF\" width=\"100%\" border=\"1\">");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("<td width=\"80%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\"></td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("<td width=\"80%\" border=\"0\" bordercolor=\"#FFFFFF\"  style=\"text-align:right;background-color:#FFFFFF;padding-right:10px;\" >" + SocietyName + "</td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("<td width=\"80%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\"></td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("<td width=\"80%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF;font-size:15px;color:black;font-weight:bold;text-align:right; padding-right:10px;\"> <p>Manager/Secretary/Treasurer/Chairman</p></td>");
            receipt.Append("</tr>");
            receipt.Append("<tr>");
            receipt.Append("<td width=\"10%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("<td width=\"80%\" border=\"0\" bordercolor=\"#FFFFFF\" style=\"background-color:#FFFFFF\">&nbsp;</td>");
            receipt.Append("</tr>");
            receipt.Append("</table></td></tr></table>");

            return receipt.ToString();
        }
    }
}