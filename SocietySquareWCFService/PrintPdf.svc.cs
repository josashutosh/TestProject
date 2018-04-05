using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Threading;
using System.IO;
using Syncfusion.Pdf;
using Syncfusion.Pdf.Graphics;
using Syncfusion.Pdf.HtmlToPdf;
using System.ServiceModel.Activation;
using System.Drawing;
using Syncfusion.Pdf.Security;
using Syncfusion.Windows.Forms.PdfViewer;
using System.Windows.Media.Imaging;


namespace SocietyWCFService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "PrintPdf" in code, svc and config file together.
    public class PrintPdf : IPrintPdf
    {
       
        public void PrintService(byte[] filestreamarray)
        {
            //Create an instance of PdfDocumentView
            PdfDocumentView view = new PdfDocumentView();
            
            //Load the document in the viewer as stream
            view.Load(new MemoryStream(filestreamarray));

            //Silently print the document to default printer
            view.PrintDocument.Print();
        }

    }
}
