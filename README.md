# Event-Entity-Profiling-for-Tamil-Documents-Nigazaayvi

# note : Huge repo - 1.4 GB. 

Online demo

தமிழிணையம் – நிகழாய்வி http://78.46.86.133:8080/tvademo/     

APK - http://78.46.86.133/TVA.apk



Title: Event - Entity Profiling for Tamil Documents – A Mobile Application
--------------------------------------------------------------------------
Funded By: Tamil Virtual Academy, Govt of Tamil Nadu, Kotturpuram, Guindy
--------------------------------------------------------------------------
Conceived & Executed By: CLRG, AU-KBC Research Centre, MIT Campus, Anna University
----------------------------------------------------------------------------------


Pre-requisites:
---------------
i) PERL - The software is developed using PERL and thus requires PERL to be pre-installed in the machine.
ii) JAVA - The GUI is developed which uses the Apache Tomcat box. Thus requires Java pre-installed in the machine.
iii) Apache Tomcat - This need to pre-installed in the machine, as the GUI is developed for the Tomcat.
iv) Operating System - Ubuntu 16.04 LTS 64 bit (Linux)
v) Conditional Random Fields (CRF++) machine leaning tool
vi) LWP::Simple perl module (tar file is provided in the folder)


Description & Usage:
--------------------
This contains the final deliverable software. The following are the files present in this CD:

i) aukbc_final_fullPlatform_withGUI.tar.gz --> 
     This tar file is when untarred contains the full syntactic-semantic Platform. This contains the full source code of the platform. The platform is provided with a graphical user interface (GUI). This GUI uses the Apache Tomcat. This untarred file should be put inside the Apache Tomcat box in its 'webapps' folder. This requires the path changes to be done as per the location you have installed Apache Tomcat and modified accordingly.

Step by Step Procedure
----------------------
Step1
tar -zxf aukbc_final_modulewise_withGUI.tar.gz
perl correctPaths.pl  fileList_tvaNLPdemo.txt <apache-path>

eg:
perl correctPaths.pl  fileList_tvaNLPdemo.txt /home/nlp/apache-tomcat-8.5.23/

Step2
Copy 'tvaNLPDemo'  apache-tomcat webapps/

Step3
chmod -R 777 tvaNLPDemo 

ii) aukbc_final_modulewise_withGUI.tar.gz -->
      This tar file is when untarred contains all individual modules along with a GUI for each module separately. This contains the full source code of all the modules. The platform is provided with a graphical user interface (GUI). This GUI uses the Apache Tomcat. This untarred file should be put inside the Apache Tomcat box in its 'webapps' folder. This requires the path changes to be done as per the location you have installed Apache Tomcat and modified accordingly.


Step by Step Procedure
----------------------
Step1
tar -zxf aukbc_final_fullPlatform_withGUI.tar.gz
perl correctPaths.pl  fileList_tvademo.txt <apache-path>

eg:
perl correctPaths.pl  fileList_tvademo.txt /home/nlp/apache-tomcat-8.5.23/

Step2
Copy 'tvademo' apache-tomcat webapps/

Step3
chmod -R 777 tvademo

iii) README.txt - The current file that you are reading.

Once the above two tar files are put inside the tomcat, then restart the tomcat.  After the tomcat is restarted, the GUI for each web application can be accessed in a browser.

Contact:
--------
Dr. Sobha L
Head, CLRG
AU-KBC Research Centre,
MIT campus, Anna University.
sobha@au-kbc.org




Source: 
http://www.tamilvu.org/ta/content/%E0%AE%A4%E0%AE%AE%E0%AE%BF%E0%AE%B4%E0%AF%8D%E0%AE%95%E0%AF%8D-%E0%AE%95%E0%AE%A3%E0%AE%BF%E0%AE%A9%E0%AE%BF%E0%AE%95%E0%AF%8D-%E0%AE%95%E0%AE%B0%E0%AF%81%E0%AE%B5%E0%AE%BF%E0%AE%95%E0%AE%B3%E0%AF%8D

Thanks to Tamil Virtual Academy, Chennai for releasing ths source code of this application.

License : GPL V2

Check https://commons.wikimedia.org/wiki/File:Tamil-Virtual-Academy-Copyright-Declaration.jpg for license info.
