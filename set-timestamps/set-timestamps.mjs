// Just a little tool to set file timestamps to match Filecoin epoch

import fs from 'fs'
import { epochToDate, dateToEpoch } from './filecoin-epochs.mjs'

const targetDir = process.argv[2]

if (!targetDir || targetDir === undefined) {
  console.error('Missing target dir')
  process.exit(1)
}

const files = fs.readdirSync(targetDir)
for (const file of files) {
  const match = file.match(/.*-(\d+)(-[^.]*)?\./)
  if (match) {
    const stat = fs.statSync(`${targetDir}/${file}`)
    const date = epochToDate(Number(match[1]))
    let touched = false
    if (stat.mtime.getTime() !== date.getTime()) {
      fs.utimesSync(`${targetDir}/${file}`, date, date)
      touched = true
    }
    console.log(file, match[1], date.toISOString(), stat.mtime, touched ? '=> touched' : '')
  }
}
