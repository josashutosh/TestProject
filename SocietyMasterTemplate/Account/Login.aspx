<%@ Page Title="" Language="C#" MasterPageFile="~/Account/NoHeadFoot.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EsquareMasterTemplate.Login1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  
    <script type="text/javascript">


        function LoginValidate() {
            var username = document.getElementById('<%=txtUsername.ClientID%>').value;
            var password = document.getElementById('<%=txtloginPassword.ClientID%>').value;

            if (username == "") {
                toastr.warning("Please Enter Your Username");
                return false;
            }
            else if (password == "") {
                toastr.warning("Please Enter password");
                return false;
            }
            return true;
        }

        function registerVlidate()
        {
            var mobilenumber, Email, Country, City, username, repassword, password, tnc;
            Email = document.getElementById('<%=txtEmail.ClientID %>').value;
            mobilenumber = document.getElementById('<%=txtMobileNumber.ClientID%>').value;
            Country = document.getElementById('<%=drpCountry.ClientID %>').value;
            City = document.getElementById('<%=txtCity.ClientID %>').value;
            username = document.getElementById('<%=txtRegUsername.ClientID %>').value;
            password = document.getElementById('<%=txtRegPassword.ClientID %>').value;
            repassword = document.getElementById('<%=txtRegrepass.ClientID %>').value;
            
            var EmailPattern = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            var Mobilepattern = /^([7-9]{1})([0-9]{9})$/;

            if (Email == "") {
                toastr.warning("Please enter Email");
                return false;
            }

            if (!EmailPattern.test(Email)) {
                toastr.warning(" Enter valid Email Id ");
                return false;

            }
            if (mobilenumber == "") {
                toastr.warning("Please enter Mobile Number");
                return false;
            }

            if (!Mobilepattern.test(mobilenumber)) {
                toastr.warning("Enter Valid Mobile number");
                return false;
            }
            if (Country === "") {
                toastr.warning("Please Select Country");
                return false;
            }

            if (City === "") {
                toastr.warning("Please enter City");
                return false;
            }

            if (username === "") {
                toastr.warning("Please enter Username");
                return false;
            }

            if (password == "") {
                toastr.warning("Please enter Password");
                return false;
            }
           if (password.length <=6) {
               toastr.warning("Please Enter Password more than 6 Charactor ");
               return false;
           }

            if (repassword != password) {
                toastr.warning("Your password not match");
                return false;
            }

            if ((document.getElementById('<%=chktnc.ClientID %>').checked) === false) {
                toastr.warning("Please Accept Term and Condition");
                return false;
            }
          return true;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%--<asp:Panel ID="PnLogin" runat="server" DefaultButton="btnLogin">--%>
    <div class="content">
        <!-- BEGIN LOGIN FORM -->
        <div class="login-form">
            <h3 class="form-title">Sign In</h3>
            <div class="alert alert-danger display-hide">
                <button class="close" data-close="alert">
                </button>
                <span>Enter any username and password. </span>
            </div>
            <div class="form-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label">
                    Username</label>
                <asp:TextBox class="form-control form-control-solid placeholder-no-fix" autocomplete="off"
                    ID="txtUsername" rel="
                    " data-content="Enter Username" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="control-label">
                    Password</label>
                <asp:TextBox class="form-control form-control-solid placeholder-no-fix" autocomplete="off"
                    ID="txtloginPassword" rel="popover" data-content="Enter Password" TextMode="Password" runat="server"></asp:TextBox>
            </div>
            <div class="form-actions">
                <asp:Button ID="btnLogin" class="btn btn-success uppercase"  runat="server" Text="Login"
                    OnClientClick="javascript:return LoginValidate()" OnClick="btnLogin_Click" /><br />

                <label class="rememberme check">
                    <asp:CheckBox ID="chkloginrememberMe" Text="Remember Password" runat="server" /><br />
                    <a href="javascript:;" id="forget-password" class="forget-password">Forgot Password?</a></label>
            </div>
           <%-- <div class="login-options">
                <h4>Or login with</h4>
                <ul class="social-icons">
                    <li><a class="social-icon-color facebook" data-original-title="facebook" href="#"></a>
                    </li>
                    <li><a class="social-icon-color twitter" data-original-title="Twitter" href="#"></a>
                    </li>
                    <li><a class="social-icon-color googleplus" data-original-title="Goole Plus" href="#"></a></li>
                    <li><a class="social-icon-color linkedin" data-original-title="Linkedin" href="#"></a>
                    </li>
                </ul>
            </div>--%>
            <div class="create-account">
                <p>
                    <a href="javascript:;" id="register-btn" class="uppercase">Create an account</a>
                </p>
            </div>
        </div>
   <%--    </asp:Panel>--%>
        <!-- END LOGIN FORM -->
        <!-- BEGIN FORGOT PASSWORD FORM -->
        <div class="forget-form">
            <h3>Forget Password ?</h3>
            <p>
                Enter your e-mail address below to reset your password.
            </p>
            <div class="form-group">
                <asp:TextBox class="form-control placeholder-no-fix" autocomplete="off" rel="popover" data-content="Enter Email Address"
                    ID="txtEmailid" runat="server"></asp:TextBox>
            </div>
            <div class="form-actions">
                <asp:Button ID="backbtn" runat="server" class="back-btn btn btn-default" Text="Back" />
                <asp:Button ID="btnForgetPass" class="btn btn-success uppercase pull-right" runat="server"
                    Text="Submit" OnClick="btnForgetPass_Click" />
            </div>
        </div>
        <!-- END FORGOT PASSWORD FORM -->
        <!-- BEGIN REGISTRATION FORM -->
        <div class="register-form">
            <h3>Sign Up</h3>
            <p class="hint">
                Enter your personal details below:
            </p>
            <%--<%if (Request.QueryString["LoginType"] != "" || Request.QueryString["Sub"] != "")%>
				<%{%>
            <div class="form-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label visible-ie8 visible-ie9">
                   dasdasdadsd</label>
                   <asp:DropDownList ID="drpRegloginType" runat="server">
                   <asp:ListItem Value="" Text="--Select--"></asp:ListItem>
                   <asp:ListItem Value="G" Text="Guest"></asp:ListItem>
                   </asp:DropDownList>
                <asp:DropDownList ID="DrpSubscription" runat="server">
                <asp:ListItem Value="" Text="--Select--"></asp:ListItem>
                <asp:ListItem Value="1" Text="Basic"></asp:ListItem>
               <asp:ListItem Value="2" Text="Economic"></asp:ListItem>
               <asp:ListItem Value="3" Text="Professional"></asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox class="form-control placeholder-no-fix" placeholder="Subscription" ID="TextBox1"
                    runat="server"></asp:TextBox>
            </div>
            	<%}%>--%>
            <div class="form-group">
                <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                <label class="control-label ">
                    Email</label>
                <asp:TextBox class="form-control placeholder-no-fix" rel="popover" data-content="Enter Email Address" ID="txtEmail"
                    runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="control-label">
                    Mobile Number</label>
                <asp:TextBox class="form-control placeholder-no-fix" rel="popover" data-content="Enter Mobile number"
                    ID="txtMobileNumber" runat="server" onkeypress="javascript:return isNumberKey(event)"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="control-label visible-ie8 visible-ie9">
                    Country</label>
                <asp:DropDownList ID="drpCountry" class="form-control" runat="server">
                    <asp:ListItem Selected="True" Value="">Country</asp:ListItem>
                    <asp:ListItem Value="AF">Afghanistan</asp:ListItem>
                    <asp:ListItem Value="AL">Albania</asp:ListItem>
                    <asp:ListItem Value="DZ">Algeria</asp:ListItem>
                    <asp:ListItem Value="AS">American Samoa</asp:ListItem>
                    <asp:ListItem Value="AD">Andorra</asp:ListItem>
                    <asp:ListItem Value="AO">Angola</asp:ListItem>
                    <asp:ListItem Value="AI">Anguilla</asp:ListItem>
                    <asp:ListItem Value="AQ">Antarctica</asp:ListItem>
                    <asp:ListItem Value="AR">Argentina</asp:ListItem>
                    <asp:ListItem Value="AM">Armenia</asp:ListItem>
                    <asp:ListItem Value="AW">Aruba</asp:ListItem>
                    <asp:ListItem Value="AU">Australia</asp:ListItem>
                    <asp:ListItem Value="AT">Austria</asp:ListItem>
                    <asp:ListItem Value="AZ">Azerbaijan</asp:ListItem>
                    <asp:ListItem Value="BS">Bahamas</asp:ListItem>
                    <asp:ListItem Value="BH">Bahrain</asp:ListItem>
                    <asp:ListItem Value="BD">Bangladesh</asp:ListItem>
                    <asp:ListItem Value="BB">Barbados</asp:ListItem>
                    <asp:ListItem Value="BY">Belarus</asp:ListItem>
                    <asp:ListItem Value="BE">Belgium</asp:ListItem>
                    <asp:ListItem Value="BZ">Belize</asp:ListItem>
                    <asp:ListItem Value="BJ">Benin</asp:ListItem>
                    <asp:ListItem Value="BM">Bermuda</asp:ListItem>
                    <asp:ListItem Value="BT">Bhutan</asp:ListItem>
                    <asp:ListItem Value="BO">Bolivia</asp:ListItem>
                    <asp:ListItem Value="BA">Bosnia and Herzegowina</asp:ListItem>
                    <asp:ListItem Value="BW">Botswana</asp:ListItem>
                    <asp:ListItem Value="BV">Bouvet Island</asp:ListItem>
                    <asp:ListItem Value="BR">Brazil</asp:ListItem>
                    <asp:ListItem Value="IO">British Indian Ocean Territory</asp:ListItem>
                    <asp:ListItem Value="BN">Brunei Darussalam</asp:ListItem>
                    <asp:ListItem Value="BG">Bulgaria</asp:ListItem>
                    <asp:ListItem Value="BF">Burkina Faso</asp:ListItem>
                    <asp:ListItem Value="BI">Burundi</asp:ListItem>
                    <asp:ListItem Value="KH">Cambodia</asp:ListItem>
                    <asp:ListItem Value="CM">Cameroon</asp:ListItem>
                    <asp:ListItem Value="CA">Canada</asp:ListItem>
                    <asp:ListItem Value="CV">Cape Verde</asp:ListItem>
                    <asp:ListItem Value="KY">Cayman Islands</asp:ListItem>
                    <asp:ListItem Value="CF">Central African Republic</asp:ListItem>
                    <asp:ListItem Value="TD">Chad</asp:ListItem>
                    <asp:ListItem Value="CL">Chile</asp:ListItem>
                    <asp:ListItem Value="CN">China</asp:ListItem>
                    <asp:ListItem Value="CX">Christmas Island</asp:ListItem>
                    <asp:ListItem Value="CC">Cocos (Keeling) Islands</asp:ListItem>
                    <asp:ListItem Value="CO">Colombia</asp:ListItem>
                    <asp:ListItem Value="KM">Comoros</asp:ListItem>
                    <asp:ListItem Value="CG">Congo</asp:ListItem>
                    <asp:ListItem Value="CD">Congo, the Democratic Republic of the</asp:ListItem>
                    <asp:ListItem Value="CK">Cook Islands</asp:ListItem>
                    <asp:ListItem Value="CR">Costa Rica</asp:ListItem>
                    <asp:ListItem Value="CI">Cote d'Ivoire</asp:ListItem>
                    <asp:ListItem Value="HR">Croatia (Hrvatska)</asp:ListItem>
                    <asp:ListItem Value="CU">Cuba</asp:ListItem>
                    <asp:ListItem Value="CY">Cyprus</asp:ListItem>
                    <asp:ListItem Value="CZ">Czech Republic</asp:ListItem>
                    <asp:ListItem Value="DK">Denmark</asp:ListItem>
                    <asp:ListItem Value="DJ">Djibouti</asp:ListItem>
                    <asp:ListItem Value="DM">Dominica</asp:ListItem>
                    <asp:ListItem Value="DO">Dominican Republic</asp:ListItem>
                    <asp:ListItem Value="EC">Ecuador</asp:ListItem>
                    <asp:ListItem Value="EG">Egypt</asp:ListItem>
                    <asp:ListItem Value="SV">El Salvador</asp:ListItem>
                    <asp:ListItem Value="GQ">Equatorial Guinea</asp:ListItem>
                    <asp:ListItem Value="ER">Eritrea</asp:ListItem>
                    <asp:ListItem Value="EE">Estonia</asp:ListItem>
                    <asp:ListItem Value="ET">Ethiopia</asp:ListItem>
                    <asp:ListItem Value="FK">Falkland Islands (Malvinas)</asp:ListItem>
                    <asp:ListItem Value="FO">Faroe Islands</asp:ListItem>
                    <asp:ListItem Value="FJ">Fiji</asp:ListItem>
                    <asp:ListItem Value="FI">Finland</asp:ListItem>
                    <asp:ListItem Value="FR">France</asp:ListItem>
                    <asp:ListItem Value="GF">French Guiana</asp:ListItem>
                    <asp:ListItem Value="PF">French Polynesia</asp:ListItem>
                    <asp:ListItem Value="TF">French Southern Territories</asp:ListItem>
                    <asp:ListItem Value="GA">Gabon</asp:ListItem>
                    <asp:ListItem Value="GM">Gambia</asp:ListItem>
                    <asp:ListItem Value="GE">Georgia</asp:ListItem>
                    <asp:ListItem Value="DE">Germany</asp:ListItem>
                    <asp:ListItem Value="GH">Ghana</asp:ListItem>
                    <asp:ListItem Value="GI">Gibraltar</asp:ListItem>
                    <asp:ListItem Value="GR">Greece</asp:ListItem>
                    <asp:ListItem Value="GL">Greenland</asp:ListItem>
                    <asp:ListItem Value="GD">Grenada</asp:ListItem>
                    <asp:ListItem Value="GP">Guadeloupe</asp:ListItem>
                    <asp:ListItem Value="GU">Guam</asp:ListItem>
                    <asp:ListItem Value="GT">Guatemala</asp:ListItem>
                    <asp:ListItem Value="GN">Guinea</asp:ListItem>
                    <asp:ListItem Value="GW">Guinea-Bissau</asp:ListItem>
                    <asp:ListItem Value="GY">Guyana</asp:ListItem>
                    <asp:ListItem Value="HT">Haiti</asp:ListItem>
                    <asp:ListItem Value="HM">Heard and Mc Donald Islands</asp:ListItem>
                    <asp:ListItem Value="VA">Holy See (Vatican City State)</asp:ListItem>
                    <asp:ListItem Value="HN">Honduras</asp:ListItem>
                    <asp:ListItem Value="HK">Hong Kong</asp:ListItem>
                    <asp:ListItem Value="HU">Hungary</asp:ListItem>
                    <asp:ListItem Value="IS">Iceland</asp:ListItem>
                    <asp:ListItem Value="IN">India</asp:ListItem>
                    <asp:ListItem Value="ID">Indonesia</asp:ListItem>
                    <asp:ListItem Value="IR">Iran (Islamic Republic of)</asp:ListItem>
                    <asp:ListItem Value="IQ">Iraq</asp:ListItem>
                    <asp:ListItem Value="IE">Ireland</asp:ListItem>
                    <asp:ListItem Value="IL">Israel</asp:ListItem>
                    <asp:ListItem Value="IT">Italy</asp:ListItem>
                    <asp:ListItem Value="JM">Jamaica</asp:ListItem>
                    <asp:ListItem Value="JP">Japan</asp:ListItem>
                    <asp:ListItem Value="JO">Jordan</asp:ListItem>
                    <asp:ListItem Value="KZ">Kazakhstan</asp:ListItem>
                    <asp:ListItem Value="KE">Kenya</asp:ListItem>
                    <asp:ListItem Value="KI">Kiribati</asp:ListItem>
                    <asp:ListItem Value="KP">Korea, Democratic People's Republic of</asp:ListItem>
                    <asp:ListItem Value="KR">Korea, Republic of</asp:ListItem>
                    <asp:ListItem Value="KW">Kuwait</asp:ListItem>
                    <asp:ListItem Value="KG">Kyrgyzstan</asp:ListItem>
                    <asp:ListItem Value="LA">Lao People's Democratic Republic</asp:ListItem>
                    <asp:ListItem Value="LV">Latvia</asp:ListItem>
                    <asp:ListItem Value="LB">Lebanon</asp:ListItem>
                    <asp:ListItem Value="LS">Lesotho</asp:ListItem>
                    <asp:ListItem Value="LR">Liberia</asp:ListItem>
                    <asp:ListItem Value="LY">Libyan Arab Jamahiriya</asp:ListItem>
                    <asp:ListItem Value="LI">Liechtenstein</asp:ListItem>
                    <asp:ListItem Value="LT">Lithuania</asp:ListItem>
                    <asp:ListItem Value="LU">Luxembourg</asp:ListItem>
                    <asp:ListItem Value="MO">Macau</asp:ListItem>
                    <asp:ListItem Value="MK">Macedonia, The Former Yugoslav Republic of</asp:ListItem>
                    <asp:ListItem Value="MG">Madagascar</asp:ListItem>
                    <asp:ListItem Value="MW">Malawi</asp:ListItem>
                    <asp:ListItem Value="MY">Malaysia</asp:ListItem>
                    <asp:ListItem Value="MV">Maldives</asp:ListItem>
                    <asp:ListItem Value="ML">Mali</asp:ListItem>
                    <asp:ListItem Value="MT">Malta</asp:ListItem>
                    <asp:ListItem Value="MH">Marshall Islands</asp:ListItem>
                    <asp:ListItem Value="MQ">Martinique</asp:ListItem>
                    <asp:ListItem Value="MR">Mauritania</asp:ListItem>
                    <asp:ListItem Value="MU">Mauritius</asp:ListItem>
                    <asp:ListItem Value="YT">Mayotte</asp:ListItem>
                    <asp:ListItem Value="MX">Mexico</asp:ListItem>
                    <asp:ListItem Value="FM">Micronesia, Federated States of</asp:ListItem>
                    <asp:ListItem Value="MD">Moldova, Republic of</asp:ListItem>
                    <asp:ListItem Value="MC">Monaco</asp:ListItem>
                    <asp:ListItem Value="MN">Mongolia</asp:ListItem>
                    <asp:ListItem Value="MS">Montserrat</asp:ListItem>
                    <asp:ListItem Value="MA">Morocco</asp:ListItem>
                    <asp:ListItem Value="MZ">Mozambique</asp:ListItem>
                    <asp:ListItem Value="MM">Myanmar</asp:ListItem>
                    <asp:ListItem Value="NA">Namibia</asp:ListItem>
                    <asp:ListItem Value="NR">Nauru</asp:ListItem>
                    <asp:ListItem Value="NP">Nepal</asp:ListItem>
                    <asp:ListItem Value="NL">Netherlands</asp:ListItem>
                    <asp:ListItem Value="AN">Netherlands Antilles</asp:ListItem>
                    <asp:ListItem Value="NC">New Caledonia</asp:ListItem>
                    <asp:ListItem Value="NZ">New Zealand</asp:ListItem>
                    <asp:ListItem Value="NI">Nicaragua</asp:ListItem>
                    <asp:ListItem Value="NE">Niger</asp:ListItem>
                    <asp:ListItem Value="NG">Nigeria</asp:ListItem>
                    <asp:ListItem Value="NU">Niue</asp:ListItem>
                    <asp:ListItem Value="NF">Norfolk Island</asp:ListItem>
                    <asp:ListItem Value="MP">Northern Mariana Islands</asp:ListItem>
                    <asp:ListItem Value="NO">Norway</asp:ListItem>
                    <asp:ListItem Value="OM">Oman</asp:ListItem>
                    <asp:ListItem Value="PK">Pakistan</asp:ListItem>
                    <asp:ListItem Value="PW">Palau</asp:ListItem>
                    <asp:ListItem Value="PA">Panama</asp:ListItem>
                    <asp:ListItem Value="PG">Papua New Guinea</asp:ListItem>
                    <asp:ListItem Value="PY">Paraguay</asp:ListItem>
                    <asp:ListItem Value="PE">Peru</asp:ListItem>
                    <asp:ListItem Value="PH">Philippines</asp:ListItem>
                    <asp:ListItem Value="PN">Pitcairn</asp:ListItem>
                    <asp:ListItem Value="PL">Poland</asp:ListItem>
                    <asp:ListItem Value="PT">Portugal</asp:ListItem>
                    <asp:ListItem Value="PR">Puerto Rico</asp:ListItem>
                    <asp:ListItem Value="QA">Qatar</asp:ListItem>
                    <asp:ListItem Value="RE">Reunion</asp:ListItem>
                    <asp:ListItem Value="RO">Romania</asp:ListItem>
                    <asp:ListItem Value="RU">Russian Federation</asp:ListItem>
                    <asp:ListItem Value="RW">Rwanda</asp:ListItem>
                    <asp:ListItem Value="KN">Saint Kitts and Nevis</asp:ListItem>
                    <asp:ListItem Value="LC">Saint LUCIA</asp:ListItem>
                    <asp:ListItem Value="VC">Saint Vincent and the Grenadines</asp:ListItem>
                    <asp:ListItem Value="WS">Samoa</asp:ListItem>
                    <asp:ListItem Value="SM">San Marino</asp:ListItem>
                    <asp:ListItem Value="ST">Sao Tome and Principe</asp:ListItem>
                    <asp:ListItem Value="SA">Saudi Arabia</asp:ListItem>
                    <asp:ListItem Value="SN">Senegal</asp:ListItem>
                    <asp:ListItem Value="SC">Seychelles</asp:ListItem>
                    <asp:ListItem Value="SL">Sierra Leone</asp:ListItem>
                    <asp:ListItem Value="SG">Singapore</asp:ListItem>
                    <asp:ListItem Value="SK">Slovakia (Slovak Republic)</asp:ListItem>
                    <asp:ListItem Value="SI">Slovenia</asp:ListItem>
                    <asp:ListItem Value="SB">Solomon Islands</asp:ListItem>
                    <asp:ListItem Value="SO">Somalia</asp:ListItem>
                    <asp:ListItem Value="ZA">South Africa</asp:ListItem>
                    <asp:ListItem Value="GS">South Georgia and the South Sandwich Islands</asp:ListItem>
                    <asp:ListItem Value="ES">Spain</asp:ListItem>
                    <asp:ListItem Value="LK">Sri Lanka</asp:ListItem>
                    <asp:ListItem Value="SH">St. Helena</asp:ListItem>
                    <asp:ListItem Value="PM">St. Pierre and Miquelon</asp:ListItem>
                    <asp:ListItem Value="SD">Sudan</asp:ListItem>
                    <asp:ListItem Value="SR">Suriname</asp:ListItem>
                    <asp:ListItem Value="SJ">Svalbard and Jan Mayen Islands</asp:ListItem>
                    <asp:ListItem Value="SZ">Swaziland</asp:ListItem>
                    <asp:ListItem Value="SE">Sweden</asp:ListItem>
                    <asp:ListItem Value="CH">Switzerland</asp:ListItem>
                    <asp:ListItem Value="SY">Syrian Arab Republic</asp:ListItem>
                    <asp:ListItem Value="TW">Taiwan, Province of China</asp:ListItem>
                    <asp:ListItem Value="TJ">Tajikistan</asp:ListItem>
                    <asp:ListItem Value="TZ">Tanzania, United Republic of</asp:ListItem>
                    <asp:ListItem Value="TH">Thailand</asp:ListItem>
                    <asp:ListItem Value="TG">Togo</asp:ListItem>
                    <asp:ListItem Value="TK">Tokelau</asp:ListItem>
                    <asp:ListItem Value="TO">Tonga</asp:ListItem>
                    <asp:ListItem Value="TT">Trinidad and Tobago</asp:ListItem>
                    <asp:ListItem Value="TN">Tunisia</asp:ListItem>
                    <asp:ListItem Value="TR">Turkey</asp:ListItem>
                    <asp:ListItem Value="TM">Turkmenistan</asp:ListItem>
                    <asp:ListItem Value="TC">Turks and Caicos Islands</asp:ListItem>
                    <asp:ListItem Value="TV">Tuvalu</asp:ListItem>
                    <asp:ListItem Value="UG">Uganda</asp:ListItem>
                    <asp:ListItem Value="UA">Ukraine</asp:ListItem>
                    <asp:ListItem Value="AE">United Arab Emirates</asp:ListItem>
                    <asp:ListItem Value="GB">United Kingdom</asp:ListItem>
                    <asp:ListItem Value="US">United States</asp:ListItem>
                    <asp:ListItem Value="UM">United States Minor Outlying Islands</asp:ListItem>
                    <asp:ListItem Value="UY">Uruguay</asp:ListItem>
                    <asp:ListItem Value="UZ">Uzbekistan</asp:ListItem>
                    <asp:ListItem Value="VU">Vanuatu</asp:ListItem>
                    <asp:ListItem Value="VE">Venezuela</asp:ListItem>
                    <asp:ListItem Value="VN">Viet Nam</asp:ListItem>
                    <asp:ListItem Value="VG">Virgin Islands (British)</asp:ListItem>
                    <asp:ListItem Value="VI">Virgin Islands (U.S.)</asp:ListItem>
                    <asp:ListItem Value="WF">Wallis and Futuna Islands</asp:ListItem>
                    <asp:ListItem Value="EH">Western Sahara</asp:ListItem>
                    <asp:ListItem Value="YE">Yemen</asp:ListItem>
                    <asp:ListItem Value="ZM">Zambia</asp:ListItem>
                    <asp:ListItem Value="ZW">Zimbabwe</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label class="control-label">
                    City/Town</label>
                <asp:TextBox ID="txtCity" class="form-control placeholder-no-fix" rel="popover" data-content="Enter Your City/Town"
                    runat="server"></asp:TextBox>
            </div>
            <p class="hint">
                Enter your account details below:
            </p>
            <div class="form-group">
                <label class="control-label">
                    Username</label>
                <asp:TextBox ID="txtRegUsername" class="username form-control placeholder-no-fix"
                    AutoComplete="off" rel="popover" data-content="Enter Username" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="control-label">
                    Password</label>
                <asp:TextBox ID="txtRegPassword" autocomplete="off" TextMode="Password" class="Password form-control placeholder-no-fix"
                    rel="popover" data-content="Enter Password" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="control-label">
                    Re-type Your Password</label>
                <asp:TextBox ID="txtRegrepass" autocomplete="off" TextMode="Password" class="form-control placeholder-no-fix"
                     rel="popover" data-content="Enter Retype Your Password" runat="server"></asp:TextBox>
            </div>
            <div class="form-group margin-top-20 margin-bottom-20">
                <label class="check">
                    <asp:CheckBox ID="chktnc" runat="server" />
                    I agree to the <a href="#">Terms of Service </a>& <a href="#">Privacy Policy </a>
                </label>
                <div id="register_tnc_error">
                </div>
            </div>
            <div class="form-actions">
                <asp:Button ID="btnregisterback" class="register-back-btn btn btn-default" runat="server"
                    Text="Back" />
                <asp:Button ID="btnregisters" OnClientClick="javascript:return registerVlidate();" class="register-submit-btn btn btn-success uppercase pull-right"
                    runat="server" Text="Submit" OnClick="btnregisters_Click" />
            </div>
        </div>
        <!-- END REGISTRATION FORM -->
    </div>
</asp:Content>
