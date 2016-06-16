cd webapps/contentservices
start "Content Services" run.bat
cd ../orchestrator
start "Orchestrator" run.bat
cd ../portalserver
if "%1" == "-d" (
	start "Portal Server" run_with_demo.bat
) else (
	start "Portal Server" run.bat
)