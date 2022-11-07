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
import Ubuntu.Components.Pickers 1.3
import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Pickers 1.3
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
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('qmldatefrom')
        }
    Settings {
		id: settings
		property string nome: 'numerone'
		property string data: '2022-11-01'
    }

Rectangle {
            anchors {
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        Image {
            anchors.fill: parent
            source: '../assets/Background.jpg'
        }

	Column {
		Row {
	            Label {
        	    	text: i18n.tr('Insert the name')+qsTr(':')
        	    	color: 'white'
       		     }
	    	     TextField {
	    	     	id: name
			text: settings.value('nome', 'numerone')
		     }
	      }
	      Label {
	         text: i18n.tr('Insert the date')
	         color: 'white'
	      }
              DatePicker {
        	id: datePicker
        	date: settings.value('data', '2022-11-01')
        	minimum: new Date( Qt.formatDate('1980-01-01', 'yyyy-MM-dd'))
        	maximum: new Date()
    	    }

	    Button {
            	text: i18n.tr('Calculate');
            	onClicked: {
            		var actual = new Date( Qt.formatDate(datePicker.date, 'yyyy-MM-dd'));
            		var now= new Date();
            		var data=now-actual.getTime();
            	        data=Math.floor(data / (1000 * 3600 * 24));
            	        var anniversary=""
            	        if (actual.getDate()==now.getDate())
            	        	if (actual.getMonth()==now.getMonth())
            	        		anniversary=i18n.tr('Is your anniversary');
            	        	else
            	        		anniversary=i18n.tr('Is your mesiversary');

            		result.text=i18n.tr('You meet')+qsTr(' ')+name.text+i18n.tr(' about ')+data+ i18n.tr(' days ago.');
            		result1.text=anniversary
            		settings.setValue('nome', name.text)
            		settings.setValue('data', datePicker.date)
            		settings.sync
            	}
    	  }
    	  Label {
    	  	id: result
    	  	text: qsTr('')
        	color: 'white'
    	  }
    	  Label {
    	  	id: result1
    	  	text: qsTr('')
    	  	color: 'white'
    	  }
    	  Label {
    	  	text: qsTr('© 2022 Giulio Sorrentino')
    	  	color: 'white'
    	  }
    	  Label {
    	  	text: qsTr('Sotto licenza GPL v3 o, secondo la tua opinione, qualsiasi\nversione successiva.')
    	  	color: 'white'
	  }
	  Label {
	  	text: qsTr('Pagina del progdetto: https://github.com/numerunix/qmldatefrom')
	  	color: 'white'
	  }
    	  
   }	
      }
   }
}
