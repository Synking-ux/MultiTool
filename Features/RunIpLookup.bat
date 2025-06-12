@echo off
title IP Lookup Tool
:: Run the PowerShell script
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0IpLookup.ps1"
