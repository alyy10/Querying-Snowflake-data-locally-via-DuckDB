# Quick launcher: opens DuckDB with the playground DB attached to Snowflake.
# Usage:  pwsh .\start.ps1
$ErrorActionPreference = "Stop"
$duckdb = "$env:LOCALAPPDATA\Microsoft\WinGet\Packages\DuckDB.cli_Microsoft.Winget.Source_8wekyb3d8bbwe\duckdb.exe"
$here = Split-Path -Parent $PSCommandPath
& $duckdb "$here\duckdb_playground.duckdb" -init "$here\connect.sql"
