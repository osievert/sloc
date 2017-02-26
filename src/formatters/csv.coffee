###
convert data to CSV format for easy import into spreadsheets
###

sloc = require '../sloc'
i18n = require '../i18n'

module.exports = (data, options={}, fmtOpts) ->

  return console.error "Error: missing data" unless data?

  if 'no-head' in fmtOpts
    lines = ''
  else
    lines = "#{i18n.en.Path},#{(i18n.en[k] for k in sloc.keys).join ','}"
    if (s = data.summary)?
      lines += ",Number of files"
    lines += "\n"

  lineize = (t) -> (t[k] for k in sloc.keys).join ','

  if options.details
    for f in data.files when f.stats?
      lines += "#{f.path},#{lineize f.stats}\n"
  else if (s = data.summary)?
    lines += i18n.en.Total + ',' + lineize s
    lines += ',' + data.files.length

  if lines[lines.length-1] is '\n'
    lines = lines.slice 0, -1
  lines
