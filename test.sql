SET DEFINE OFF;
SET SQLBLANKLINES ON;

MERGE INTO HELP_TEXTS T
USING (
      SELECT 'Test' AS HELP_TEXT_DESCRIPTION,'<ul><li>Updates to the approved project:&nbsp;update the approved project by completing steps to “Create site modification/Update study details” (on the left side of the workspace).</li><li>Continuing review:&nbsp;report on continuing review by completing the "Report Continuing Review Data" (on the left side of the workspace). Note that this activity is only visible to the Harvard Principal Investigator.</li></ul>' AS HELP_TEXT,'Test' AS HELP_TEXT_KEY FROM DUAL
) S
ON (T.HELP_TEXT_KEY = S.HELP_TEXT_KEY)
WHEN MATCHED THEN
      UPDATE SET T.HELP_TEXT_DESCRIPTION = S.HELP_TEXT_DESCRIPTION, T.HELP_TEXT = S.HELP_TEXT
WHEN NOT MATCHED THEN
      INSERT (T.HELP_TEXT_ID,T.HELP_TEXT_DESCRIPTION,T.HELP_TEXT,T.HELP_TEXT_KEY) VALUES (HELP_TEXT_SEQ.NEXTVAL,S.HELP_TEXT_DESCRIPTION,S.HELP_TEXT,S.HELP_TEXT_KEY);

COMMIT;
