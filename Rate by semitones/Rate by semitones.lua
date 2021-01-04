--[[
 * ReaScript Name: 
 * Author: Daniel Lumertz
 * Licence: GPL v3
 * REAPER: 6.15
 * Extensions: none
 * Version: 1.0
--]]
 
--[[
 * Changelog:
 * v1.0 (2016-01-29)
 	+ Initial Release
--]]


reaper.Undo_BeginBlock()
reaper.ShowConsoleMsg("")
actual_rate = reaper.Master_GetPlayRate( 0 )
actual_rate_in_st =  12 * math.log(actual_rate,2)
retval, retvals_csv = reaper.GetUserInputs( "Rate in Semitones", 2, "Change Rate to, Acutal Rate in Semitones", "0,"..tostring(actual_rate_in_st) )
  if retval == false then return end
retvals_csv, _= retvals_csv:match("([^,]+),([^,]+)")
retvals_csv = tonumber(retvals_csv)
new_in_st = 2^(retvals_csv/12)
reaper.CSurf_OnPlayRateChange(new_in_st)
reaper.Undo_EndBlock( "Rate in Semitones" , -1 )






--[[  --easter egg: I found this way to get abusrd playrate values not limited to reaper max = 10 
like
 for i = 0 ,2^(100/12) do
         reaper.Main_OnCommand( 40522, 0 )--increase by semitones
 end
]]
