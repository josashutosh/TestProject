
//Controls List
window.SampleControls = [
    { "name": "Pdf" }, { "name": "DocIO" }, { "name": "XlsIO" }
];
//Samples List
window.SamplesList = [
    
                			   {
                			       "name": "XlsIO", "id": "XlsIO", "childcount": "1", "controller": "XlsIO", "action": "Default", "samples": [
                        { "id": "1", "name": "Default", "controller": "XlsIO", "action": "Default", "childcount": "0" },
                        {
                            "id": "2", "name": "Product Showcase", "controller": "XlsIO", "action": "BudgetPlanner", "childcount": "1", samples: [
                                { "id": "1", "name": "Budget Planner", "controller": "XlsIO", "action": "BudgetPlanner", "childcount": "0" },
                                { "id": "2", "name": "Excel To PDF", "controller": "XlsIO", "action": "ExcelToPDF", "childcount": "0" }
                            ]
                        },
                        {
                            "id": "3", "name": "Getting Started", "controller": "XlsIO", "action": "Create", "childcount": "1", samples: [
                                { "id": "1", "name": "Create", "controller": "XlsIO", "action": "Create", "childcount": "0" },
                                { "id": "2", "name": "Find And Extract", "controller": "XlsIO", "action": "FindAndExtract", "childcount": "0" }
                            ]
                        },
                        {
                            "id": "4", "name": "Formatting", "controller": "XlsIO", "action": "FormatCells", "childcount": "1", samples: [
                                { "id": "1", "name": "Format Cells", "controller": "XlsIO", "action": "FormatCells", "childcount": "0" },
                                { "id": "2", "name": "Styles And Formatting", "controller": "XlsIO", "action": "StylesAndFormatting", "childcount": "0" },
                                { "id": "3", "name": "Conditional Formatting", "controller": "XlsIO", "action": "ConditionalFormatting", "childcount": "0" }
                            ]
                        },
                        {
                            "id": "5", "name": "Charts", "controller": "XlsIO", "action": "ChartWorksheet", "childcount": "1", samples: [
                                { "id": "1", "name": "Chart Worksheet", "controller": "XlsIO", "action": "ChartWorksheet", "childcount": "0" },
                                { "id": "2", "name": "Embedded Chart", "controller": "XlsIO", "action": "EmbeddedChart", "childcount": "0" },
                                { "id": "3", "name": "Sparklines", "controller": "XlsIO", "action": "Sparklines", "childcount": "0" }
                            ]
                        },
                        {
                            "id": "6", "name": "Data Management", "controller": "XlsIO", "action": "RangeManipulation", "childcount": "1", samples: [
                                { "id": "1", "name": "Range Manipulation", "controller": "XlsIO", "action": "RangeManipulation", "childcount": "0" },
                                { "id": "2", "name": "Formulas", "controller": "XlsIO", "action": "Formulas", "childcount": "0" },
                                { "id": "3", "name": "Compute All Formulas", "controller": "XlsIO", "action": "ComputeAllformulas", "childcount": "0" },
                                { "id": "4", "name": "Data Validation", "controller": "XlsIO", "action": "DataValidation", "childcount": "0" },
                                { "id": "5", "name": "Performance", "controller": "XlsIO", "action": "Performance", "childcount": "0" },
                                { "id": "6", "name": "Interactive Features", "controller": "XlsIO", "action": "InteractiveFeatures", "childcount": "0" },
                                { "id": "7", "name": "Form Controls", "controller": "XlsIO", "action": "FormControls", "childcount": "0" },
                                { "id": "8", "name": "Data Sorting", "controller": "XlsIO", "action": "DataSorting", "childcount": "0" }
                            ]

                        },
                        {
                            "id": "7", "name": "Data Binding", "controller": "XlsIO", "action": "ExternalConnection", "childcount": "1", samples: [
                                { "id": "1", "name": "External Connection", "controller": "XlsIO", "action": "ExternalConnection", "childcount": "0" },
                                { "id": "2", "name": "Template Marker", "controller": "XlsIO", "action": "TemplateMarker", "childcount": "0" },
                                { "id": "3", "name": "Business Objects", "controller": "XlsIO", "action": "BusinessObjects", "childcount": "0" },
                                { "id": "4", "name": "Invoice", "controller": "XlsIO", "action": "Invoice", "childcount": "0" }
                            ]
                        },
                        {
                            "id": "8", "name": "Sheet Manipulations", "controller": "XlsIO", "action": "RowColumnManipulation", "childcount": "1", samples: [
                                { "id": "1", "name": "Row-Column Manipulation", "controller": "XlsIO", "action": "RowColumnManipulation", "childcount": "0" },
                                { "id": "2", "name": "Worksheet Manipulation", "controller": "XlsIO", "action": "WorksheetManipulation", "childcount": "0" },
                                { "id": "3", "name": "Worksheet To Image", "controller": "XlsIO", "action": "WorksheetToImage", "childcount": "0" }
                            ]
                        },
                        {
                            "id": "9", "name": "Settings", "controller": "XlsIO", "action": "DocumentationSettings", "childcount": "1", samples: [
                                { "id": "1", "name": "Documentation Settings", "controller": "XlsIO", "action": "DocumentationSettings", "childcount": "0" },
                                { "id": "2", "name": "Worksheet Protection", "controller": "XlsIO", "action": "WorksheetProtection", "childcount": "0" },
                                { "id": "3", "name": "Workbook Protection", "controller": "XlsIO", "action": "WorkbookProtection", "childcount": "0" },
                                { "id": "4", "name": "Encrypt and Decrypt", "controller": "XlsIO", "action": "EncryptAndDecrypt", "childcount": "0" }
                            ]
                        },
                        {
                            "id": "10", "name": "Business Intelligence", "controller": "XlsIO", "action": "Tables", "childcount": "1", samples: [
                                { "id": "1", "name": "Tables", "controller": "XlsIO", "action": "Tables", "childcount": "0" },
                                { "id": "2", "name": "Pivot Table", "controller": "XlsIO", "action": "PivotTable", "childcount": "0" },
                                { "id": "3", "name": "Pivot Chart", "controller": "XlsIO", "action": "PivotChart", "childcount": "0" }
                            ]
                        },
                        {
                            "id": "11", "name": "Shapes", "controller": "XlsIO", "action": "AutoShapes", "childcount": "1", samples: [
                                { "id": "1", "name": "AutoShapes", "controller": "XlsIO", "action": "AutoShapes", "childcount": "0" }
                            ]
                        }
                			       ]
                			   },
                                         {

                                             "name": "Pdf", "id": "Pdf", "childcount": "2", "controller": "Pdf", "action": "Default", "samples": [

                                        { "id": "1", "name": "Default", "controller": "Pdf", "action": "Default", "childcount": "0" },

                                        {
                                            "id": "2", "name": "Product Showcase", "controller": "Pdf", "action": "JobApplication", "childcount": "1", "samples": [
                                         { "id": "1", "name": "Job Application Sample", "controller": "Pdf", "action": "JobApplication", "childcount": "0" },
                                         { "id": "2", "name": "Invoice Sample", "controller": "Pdf", "action": "InvoiceSample", "childcount": "0" }
                                            ]
                                        },
                                        {
                                            "id": "3", "name": "Getting Started", "controller": "Pdf", "action": "HelloWorld", "childcount": "1", "samples": [
                                           { "id": "1", "name": "Hello World Sample", "controller": "Pdf", "action": "HelloWorld", "childcount": "0" },
                                           { "id": "2", "name": "PDF Conformance Sample", "controller": "Pdf", "action": "PdfConformance", "childcount": "0" },
                                           { "id": "3", "name": "PDF Compression Sample", "controller": "Pdf", "action": "PdfCompression", "childcount": "0" }
                                            ]
                                        },
                                          {
                                              "id": "4", "name": "Graphics", "controller": "Pdf", "action": "Barcode", "childcount": "1", "samples": [
                                           { "id": "1", "name": "Barcode Sample", "controller": "Pdf", "action": "Barcode", "childcount": "0" },
                                           { "id": "2", "name": "Drawing Shapes Sample", "controller": "Pdf", "action": "DrawingShapes", "childcount": "0" },
                                           { "id": "3", "name": "Graphic Brushes Sample", "controller": "Pdf", "action": "GraphicBrushes", "childcount": "0" },
                                           { "id": "4", "name": "Image Insertion Sample", "controller": "Pdf", "action": "ImageInsertion", "childcount": "0" }
                                              ]
                                          },

                                           {
                                               "id": "5", "name": "Tables", "controller": "Pdf", "action": "NorthwindReport", "childcount": "1", "samples": [
                                          { "id": "1", "name": "Northwind Report Sample", "controller": "Pdf", "action": "NorthwindReport", "childcount": "0" },
                                          { "id": "2", "name": "Table Features Sample", "controller": "Pdf", "action": "TableFeatures", "childcount": "0" }
                                               ]
                                           },
                                            {
                                                "id": "6", "name": "Drawing Text", "controller": "Pdf", "action": "TextFlow", "childcount": "1", "samples": [
                                           { "id": "1", "name": "Text Flow Sample", "controller": "Pdf", "action": "TextFlow", "childcount": "0" },
                                           { "id": "2", "name": "RTL Support Sample", "controller": "Pdf", "action": "RtlSupport", "childcount": "0" },
                                           { "id": "3", "name": "Bullets and Lists Sample", "controller": "Pdf", "action": "BulletsandLists", "childcount": "0" },
                                           { "id": "4", "name": "Multi Column HTML Text Sample", "controller": "Pdf", "action": "MultiColumnHTMLText", "childcount": "0" }
                                                ]
                                            },

                                             {
                                                 "id": "7", "name": "Security", "controller": "Pdf", "action": "Encryption", "childcount": "1", "samples": [
                                         { "id": "1", "name": "Encryption Sample", "controller": "Pdf", "action": "Encryption", "childcount": "0" }
                                                 ]
                                             },

                                              {
                                                  "id": "8", "name": "Settings", "controller": "Pdf", "action": "DocumentSettings", "childcount": "1", "samples": [
                                           { "id": "1", "name": "Document Settings Sample", "controller": "Pdf", "action": "DocumentSettings", "childcount": "0" },
                                           { "id": "2", "name": "Page Settings Sample", "controller": "Pdf", "action": "PageSettings", "childcount": "0" },
                                           { "id": "3", "name": "Headers and Footers Sample", "controller": "Pdf", "action": "HeadersandFooters", "childcount": "0" },
                                           { "id": "4", "name": "Layers Sample", "controller": "Pdf", "action": "Layers", "childcount": "0" }
                                                  ]
                                              },
                                              {
                                                  "id": "9", "name": "User Interaction", "controller": "Pdf", "action": "InteractiveFeatures", "childcount": "1", "samples": [
                                           { "id": "1", "name": "Interactive Features", "controller": "Pdf", "action": "InteractiveFeatures", "childcount": "0" },
                                           { "id": "2", "name": "Form Filling Sample", "controller": "Pdf", "action": "FormFilling", "childcount": "0" },
                                           { "id": "3", "name": "Portfolio", "controller": "Pdf", "action": "Portfolio", "childcount": "0" }
                                                  ]
                                              },
                                                 {
                                                     "id": "10", "name": "Import and Export", "controller": "Pdf", "action": "TextExtraction", "childcount": "1", "samples": [
                                           { "id": "1", "name": "Text Extraction Sample", "controller": "Pdf", "action": "TextExtraction", "childcount": "0" },
                                           { "id": "2", "name": "RTF to PDF Sample", "controller": "Pdf", "action": "RTFtoPDF", "childcount": "0" },
                                           { "id": "3", "name": "Doc to PDF Sample", "controller": "Pdf", "action": "DoctoPDF", "childcount": "0" },
                                           { "id": "4", "name": "Html to PDF Sample", "controller": "Pdf", "action": "HtmltoPDF", "childcount": "0" },
                                           { "id": "5", "name": "XPS to PDF Sample", "controller": "Pdf", "action": "XPStoPDF", "childcount": "0" }
                                                     ]
                                                 },

                                                       {
                                                           "id": "12", "name": "Modify Documents", "controller": "Pdf", "action": "MergeDocuments", "childcount": "1", "samples": [
                                           { "id": "1", "name": "Merge Documents Sample", "controller": "Pdf", "action": "MergeDocuments", "childcount": "0" },
                                           { "id": "2", "name": "Overlay Documents Sample", "controller": "Pdf", "action": "OverlayDocuments", "childcount": "0" },
                                           { "id": "3", "name": "Booklet Sample", "controller": "Pdf", "action": "Booklet", "childcount": "0" }
                                                           ]
                                                       },

                                                         {
                                                             "id": "13", "name": "OCR", "controller": "Pdf", "action": "PdfOCR", "childcount": "1", "samples": [
                                         { "id": "1", "name": "PDF OCR Sample", "controller": "Pdf", "action": "PdfOCR", "childcount": "0" }
                                                             ]
                                                         }
                                             ]
                                         },
                    {
                        "name": "DocIO", "id": "DocIO", "childcount": "3", "controller": "DocIO", "action": "Default", "type": "update", "samples": [
                         { "id": "1", "name": "Default", "controller": "DocIO", "action": "Default", "childcount": "0" },
                         {
                             "id": "2", "name": "Product Showcase", "controller": "DocIO", "action": "SalesInvoice", "childcount": "1", "samples": [
                                    { "id": "1", "name": "Sales Invoice", "controller": "DocIO", "action": "SalesInvoice", "childcount": "0" },
                                    { "id": "2", "name": "Update Fields", "controller": "DocIO", "action": "UpdateFields", "childcount": "0" }
                             ]
                         },
                         {
                             "id": "3", "name": "Getting Started", "controller": "DocIO", "action": "HelloWorld", "childcount": "1", "samples": [
                                     { "id": "1", "name": "Hello World", "controller": "DocIO", "action": "HelloWorld", "childcount": "0" }
                             ]
                         },
                         {
                             "id": "4", "name": "Editing", "controller": "DocIO", "action": "AdvancedReplace", "childcount": "1", "samples": [
                                      { "id": "1", "name": "Advanced Replace", "controller": "DocIO", "action": "AdvancedReplace", "childcount": "0" },
                                      { "id": "2", "name": "Bookmark Navigation", "controller": "DocIO", "action": "BookmarkNavigation", "childcount": "0" },
                                      { "id": "3", "name": "Forms", "controller": "DocIO", "action": "Forms", "childcount": "0" }
                             ]
                         },
                         {
                             "id": "5", "name": "Formatting", "controller": "DocIO", "action": "FormatTable", "childcount": "1", "samples": [
                                      { "id": "1", "name": "Format Table", "controller": "DocIO", "action": "FormatTable", "childcount": "0" },
                                      { "id": "2", "name": "Format Text", "controller": "DocIO", "action": "FormatText", "childcount": "0" },
                                      { "id": "3", "name": "RTL Support", "controller": "DocIO", "action": "RTLSupport", "childcount": "0" },
                                      { "id": "4", "name": "Styles", "controller": "DocIO", "action": "Styles", "childcount": "0" },
                                      { "id": "5", "name": "Table Styles", "controller": "DocIO", "action": "TableStyles", "childcount": "0" }
                             ]
                         },
                         {
                             "id": "6", "name": "Insert Content", "controller": "DocIO", "action": "Bookmarks", "childcount": "1", "samples": [
                                      { "id": "1", "name": "Bookmarks", "controller": "DocIO", "action": "Bookmarks", "childcount": "0" },
                                      { "id": "2", "name": "Clone and Merge", "controller": "DocIO", "action": "CloneandMerge", "childcount": "0" },
                                      { "id": "3", "name": "Header and Footer", "controller": "DocIO", "action": "HeaderandFooter", "childcount": "0" },
                                      { "id": "4", "name": "Image Insertion", "controller": "DocIO", "action": "ImageInsertion", "childcount": "0" },
                                      { "id": "5", "name": "Insert OLE Object", "controller": "DocIO", "action": "InsertOLEObject", "childcount": "0" }
                             ]
                         },
                         {
                             "id": "7", "name": "Mail Merge", "controller": "DocIO", "action": "EmployeeReport", "childcount": "1", "type": "update", "samples": [
                                      { "id": "1", "name": "Employee Report", "controller": "DocIO", "action": "EmployeeReport", "childcount": "0" },
                                      { "id": "2", "name": "Mail Merge Event", "controller": "DocIO", "action": "MailMergeEvent", "childcount": "0" },
				      { "id": "3", "name": "NestedMailMerge", "controller": "DocIO", "action": "NestedMailMerge", "childcount": "0", "type": "update" }
                             ]
                         },
                         {
                             "id": "8", "name": "Page Layout", "controller": "DocIO", "action": "InsertBreak", "childcount": "1", "samples": [
                                      { "id": "1", "name": "Insert Break", "controller": "DocIO", "action": "InsertBreak", "childcount": "0" },
                                      { "id": "2", "name": "Watermark", "controller": "DocIO", "action": "Watermark", "childcount": "0" }
                             ]
                         },
                          {
                              "id": "9", "name": "View", "controller": "DocIO", "action": "DocumentSettings", "childcount": "1", "samples": [
                                       { "id": "1", "name": "Document Settings", "controller": "DocIO", "action": "DocumentSettings", "childcount": "0" },
                                       { "id": "2", "name": "Macro Preservation", "controller": "DocIO", "action": "MacroPreservation", "childcount": "0" }
                              ]
                          },
                          {
                              "id": "10", "name": "Security", "controller": "DocIO", "action": "DocumentProtection", "childcount": "1", "samples": [
                                       { "id": "1", "name": "Document Protection", "controller": "DocIO", "action": "DocumentProtection", "childcount": "0" },
                                       { "id": "2", "name": "Encrypt and Decrypt", "controller": "DocIO", "action": "EncryptandDecrypt", "childcount": "0" }
                              ]
                          },
                          {
                              "id": "11", "name": "References", "controller": "DocIO", "action": "FootnotesandEndnotes", "childcount": "1", "samples": [
                                       { "id": "1", "name": "Footnotes and Endnotes", "controller": "DocIO", "action": "FootnotesandEndnotes", "childcount": "0" },
                                       { "id": "2", "name": "Table of Content", "controller": "DocIO", "action": "TableofContent", "childcount": "0" }
                              ]
                          },
                          {
                              "id": "12", "name": "Import and Export", "controller": "DocIO", "action": "DOCToEPub", "childcount": "1", "samples": [
                                       { "id": "1", "name": "Word to EPub", "controller": "DocIO", "action": "DOCToEPub", "childcount": "0" },
                                       { "id": "2", "name": "Word to PDF", "controller": "DocIO", "action": "DOCtoPDF", "childcount": "0"},
                                       { "id": "3", "name": "HTML to Word", "controller": "DocIO", "action": "HTMLtoDOC", "childcount": "0" },
                                       { "id": "4", "name": "RTF to Word", "controller": "DocIO", "action": "RTFToDoc", "childcount": "0" },
                                       { "id": "5", "name": "Word to Image", "controller": "DocIO", "action": "WordtoImage", "childcount": "0" }
                              ]
                          },
                           {
                               "id": "13", "name": "Shapes", "controller": "DocIO", "action": "AutoShapes", "childcount": "1", "samples": [
                                        { "id": "1", "name": "AutoShapes", "controller": "DocIO", "action": "AutoShapes", "childcount": "0" }
                               ]
                           }
                        ]
                    },
                    

];
