bat_text = widget({ type = "textbox", align = "right" })

function bat_refresh()
  local udi = awful.util.pread("hal-find-by-property --key info.category --string battery")

  if udi == "" then
    return nil
  end

  local level = string.gsub(awful.util.pread("hal-get-property --key battery.charge_level.percentage --udi " .. udi),  "%s*$",  "")
  bat_text.text = level .. "%"

  return true
end

bat_status = bat_refresh()
