/*
 * Copyright (C) 2022  Giulio Sorrentino
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * qmldatefrom is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'qmldatefrom'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

Page {
    title: qsTr("QMLDateFrom")
    Settings {
		id: "settings"
		property string nome: "numerone"
		property string data: "2022-11-01"
    }
    Column{
       		spacing: 30
       	    Row {
       	    	spacing: 10
       	    	Label {
       	    		text: i18n.tr("Insert the name: ")
       	    	}
       	    	TextEdit {
       	    		id: name
       	    		text: settings.value("nome", "numerone")
       	    	}
       	    }
	    Row {
       		spacing: 10
	        Label {
	            text: i18n.tr("Insert the date")
	        }
	        TextEdit {
	        	id: date
	        	text: settings.value("data", "2022-11-01")
	        }
	   }
       	   Button {
            	text: i18n.tr("Calculate");
            	onClicked: {
            		var actual = new Date( Qt.formatDate(date.text, "yyyy-MM-dd"));
            		var now= new Date();
            		var data=now-actual.getTime();
            	        data=Math.floor(data / (1000 * 3600 * 24));
            	        var anniversary=""
            	        if (actual.getDate()==now.getDate())
            	        	if (actual.getMonth()==now.getMonth())
            	        		anniversary=i18n.tr("Is your anniversary");
            	        	else
            	        		anniversary=i18n.tr("Is your mesiversary");

            		result.text=i18n.tr("You meet")+qsTr(" ")+name.text+i18n.tr(" about ")+data+ i18n.tr(" days ago.")+anniversary;
            		settings.setValue("nome", name.text)
            		settings.setValue("data", date.text)
            		settings.sync()
            	}
    	  }
    	  Label {
    	  	id: result
    	  	text: qsTr("Fatto dal coglione italo-napoletano");
    	  }
   }
 }
}

