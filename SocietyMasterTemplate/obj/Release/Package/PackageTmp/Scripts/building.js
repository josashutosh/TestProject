/**
Core script to handle the entire theme and core functions
**/
//var building = function () {

    function buildingvalidation () {

        var buildingname = document.getElementById('<%=txtBuildingname.ClientID%>').value;
        var floor = document.getElementById('<%=txtFloors.ClientID%>').value;
        var flats = document.getElementById('<%=txtFlats.ClientID%>').value;
        var totalarea = document.getElementById('<%=txtArea.ClientID%>').value;

        if (buildingname == "") {
            bootbox.alert("Enter Building name");
            return false;
        }
        if (flats == "") {
            bootbox.alert("Enter Number of Flats");
            return false;
        }
        if (floor == "") {
            bootbox.alert("Enter Number of Floors");
            return false;
        }

        if (totalarea == "") {
            bootbox.alert("Enter Total Area");
            return false;
        }
        return true;
    
    }

     init: function () {
        	
          //  buildingvalidation();
                
	       
        }

} ();