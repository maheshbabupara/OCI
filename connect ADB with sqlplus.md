- Uploaded `wallet.zip` file into github and Downloaded `wallet.zip` file by using `wget` command [`wget -N -O wallet.zip https://github.com/maheshbabupara/TEST/blob/main/Wallet_DB_1.zip`]
- created wallet directory [`mkdir wallet`]
- unzip `wallet.zip` to wallet directory [`unzip Wallet.zip -d /home/maheshbabu/wallet`]
- set `TNS_ADMIN` environment variable with above unzipped wallet path [`export TNS_ADMIN=/home/maheshbabu/wallet` `echo $TNS_ADMIN` to see value in it]
- Replace `?/network/admin` with above path in `sqlnet.ora` file which is available in the unzipped wallet path [`vi sqlnet.ora`]
- now login to the execute `sqlplus <username>@<sevice available in tnsname.ora file>` [`sqlplus mahesh@db_high`]
- Note: If the password has "@" then enclose the password within the double quotes [password:`"Mahesh@12"`]
- To execute a sql file use syntax like `@<path><filename>` [`@/home/maheshbabu/test.sql`]

### Others
#### To Resolve the issue of some special characters are converting into quetion mark symbol when we run the script from sqlplus (“ converted to ���)
##### Sample Script
<pre>
  SET DEFINE OFF;
SET SQLBLANKLINES ON;

MERGE INTO HELP_TEXTS T
USING (
      SELECT 'Active IRB protocols that have passed their expiration date.' AS HELP_TEXT_DESCRIPTION,'<p>The IRB approval of this study may have expired. For details, click the submission link to go to the project workspace.</p><p style="margin-left:0px;">Required updates to the Harvard IRB include:</p><ul><li>Updates to the approved project:&nbsp;update the approved project by completing steps to “Create site modification/Update study details” (on the left side of the workspace).</li><li>Continuing review:&nbsp;report on continuing review by completing the "Report Continuing Review Data" (on the left side of the workspace). Note that this activity is only visible to the Harvard Principal Investigator.</li><li>Closure of the study with Harvard:&nbsp;request closure completing the "Report Continuing Review Data" activity (on the left side of the workspace). Note that this activity is only visible to the Harvard Principal Investigator.</li><li>Any Reports of New Information:&nbsp;complete steps to “Report New Information” (on the left side of the workspace). Reporting details:<ul><li><a href="https://irb.harvard.edu/IRB/sd/Doc/0/27OCM2QETKU4TESR3GMPVGKSC7/HRP-103-HUA%20Investigator%20Manual.pdf">Harvard University Area Investigator Manual</a></li><li><a href="https://irb.harvard.edu/IRB/sd/Doc/0/488V4CVOPCAKN72LEMSAOG9S0F/HRP-103-HLC%20Investigator%20Manual.pdf">Harvard Longwood Campus&nbsp;Investigator Manual</a></li></ul></li></ul>' AS HELP_TEXT,'ESTRExpired' AS HELP_TEXT_KEY FROM DUAL
) S
ON (T.HELP_TEXT_KEY = S.HELP_TEXT_KEY)
WHEN MATCHED THEN
      UPDATE SET T.HELP_TEXT_DESCRIPTION = S.HELP_TEXT_DESCRIPTION, T.HELP_TEXT = S.HELP_TEXT
WHEN NOT MATCHED THEN
      INSERT (T.HELP_TEXT_ID,T.HELP_TEXT_DESCRIPTION,T.HELP_TEXT,T.HELP_TEXT_KEY) VALUES (HELP_TEXT_SEQ.NEXTVAL,S.HELP_TEXT_DESCRIPTION,S.HELP_TEXT,S.HELP_TEXT_KEY);

COMMIT;
</pre>
- When we run the above script from sqlplus the special characters “ being converted to ���
- To fix this execute `export NLS_LANG=AMERICAN_AMERICA.UTF8` command as a linux command before running or opening sqlplus

select * from nls_database_parameters where parameter='NLS_LANGUAGE';

