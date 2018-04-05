using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;


namespace EsquareMasterTemplate
{
    public class BundleConfig
    {

        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.UseCdn = true;
            var jqueryCdnPath = "http://code.jquery.com/jquery-1.11.1.js";
            var jqueryuiCdnPath = "http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.js";

            bundles.Add(new ScriptBundle("~/bundles/jquery", jqueryCdnPath).Include(
                            "~/ThemeAssets/global/plugins/jquery.js"
                            ));

            bundles.Add(new ScriptBundle("~/bundles/jqueryui", jqueryuiCdnPath).Include(
                        "~/ThemeAssets/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.js"
                        ));


            bundles.Add(new ScriptBundle("~/bundles/CommonJs").Include(
                 "~/ThemeAssets/global/plugins/jquery-migrate.js",
                 "~/ThemeAssets/global/plugins/bootstrap/js/bootstrap.js",
           "~/ThemeAssets/global/plugins/bootbox/bootbox.js",
           "~/ThemeAssets/global/plugins/jquery.blockui.js",
           "~/ThemeAssets/global/plugins/bootstrap-toastr/toastr.js"
                  ));
            

            bundles.Add(new ScriptBundle("~/bundles/MasterExtra").Include(
           "~/ThemeAssets/global/plugins/icheck/icheck.js",
           "~/ThemeAssets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.js",
            "~/ThemeAssets/global/plugins/Multiselect/bootstrap-multiselect.js",
            "~/ThemeAssets/global/plugins/select2/select2.js",
            "~/ThemeAssets/global/plugins/jquery-slimscroll/jquery.slimscroll.js",
            "~/ThemeAssets/global/plugins/bootstrap-modal/js/bootstrap-modal.js",
            "~/ThemeAssets/global/plugins/bootstrap-modal/js/bootstrap-modalmanager.js"
            ));


            bundles.Add(new ScriptBundle("~/bundles/Datepicker").Include(
           "~/ThemeAssets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js",
           "~/ThemeAssets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"
          ));

            bundles.Add(new ScriptBundle("~/bundles/LoginJs").Include(
          "~/ThemeAssets/global/plugins/bootstrap-pwstrength/pwstrength-bootstrap.js",
          "~/ThemeAssets/admin/pages/scripts/login.js",
          "~/ThemeAssets/global/plugins/select2/select2.js"
         
           ));

            bundles.Add(new ScriptBundle("~/bundles/CommonJsSetting").Include(
              "~/ThemeAssets/global/scripts/metronic.js",
              "~/ThemeAssets/admin/layout/scripts/layout.js",
              "~/Scripts/Custom.js"
               ));


            bundles.Add(new ScriptBundle("~/bundles/MasterView").Include(
             "~/ThemeAssets/global/plugins/jquery-slimscroll/jquery.slimscroll.js",
            "~/ThemeAssets/global/plugins/bootstrap-modal/js/bootstrap-modal.js",
            "~/ThemeAssets/global/plugins/bootstrap-modal/js/bootstrap-modalmanager.js",
             "~/ThemeAssets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.js",
               "~/ThemeAssets/global/plugins/select2/select2.js",
             "~/Scripts/Custom.js"
              ));
            
            bundles.Add(new ScriptBundle("~/ThemeAssets/content/CommonStyle").Include(
                "~/ThemeAssets/global/plugins/bootstrap/css/bootstrap.css",
                       "~/ThemeAssets/global/css/components.css",
                       "~/ThemeAssets/global/plugins/bootstrap-toastr/toastr.css",
                       "~/ThemeAssets/global/css/plugins.css",
                       "~/ThemeAssets/global/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css",
                       "~/ThemeAssets/global/plugins/bootstrap-modal/css/bootstrap-modal.css",
                       "~/ThemeAssets/admin/layout/css/layout.css",
                       "~/ThemeAssets/admin/layout/css/custom.css"
                       ));


            bundles.Add(new ScriptBundle("~/ThemeAssets/content/LogindefaltTheme").Include(
                "~/ThemeAssets/admin/pages/css/login.css",
                "~/ThemeAssets/admin/layout/css/themes/default.css"
                       ));

            bundles.Add(new ScriptBundle("~/ThemeAssets/content/MasterdefaltTheme").Include(
               "~/ThemeAssets/admin/layout/css/themes/darkblue.css"
                      ));

            bundles.Add(new ScriptBundle("~/ThemeAssets/content/ProfileMaster").Include(
               "~/ThemeAssets/admin/pages/css/profile.css",
               "~/ThemeAssets/admin/pages/css/tasks.css",
               "~/ThemeAssets/global/plugins/jquery-tags-input/jquery.tagsinput.css"
              ));
            
            bundles.Add(new ScriptBundle("~/ThemeAssets/content/MasterExtraCss").Include(
                "~/ThemeAssets/global/plugins/icheck/skins/square/green.css",
                "~/ThemeAssets/global/plugins/bootstrap-summernote/summernote.css",
                "~/ThemeAssets/global/plugins/Multiselect/bootstrap-multiselect.css",
                "~/ThemeAssets/global/plugins/select2/select2.css",
                "~/ThemeAssets/global/plugins/bootstrap-datepicker/css/datepicker3.css"
               ));

        }

           
    }
}