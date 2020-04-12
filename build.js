#!/usr/bin/env node
const fs = require('fs')
const path = require('path')
const child_process = require('child_process')

const projectName = 'Indigo'
const godotBin = process.env.GODOT || 'godot'
const srcPath = path.resolve(__dirname, 'src')
const dstPath = path.resolve(__dirname, 'build')

let baseCommand = `"${godotBin}" --path "${srcPath}" --no-window`

async function make(template, subDir, name) {
  console.log(`\x1b[33m\x1b[1mBuild ${template}\x1b[0m`)

  const buildPath = path.join(dstPath, subDir)

  if (fs.existsSync(buildPath)) {
    fs.rmdirSync(buildPath, {
      recursive: true
    })
  }

  fs.mkdirSync(buildPath)

  return new Promise(resolve => {
    child_process.exec(
      `${baseCommand} --export "${template}" "${path.join(buildPath, name)}"`,
      (err, stdout, stderr) => {
        if (err) console.error(err)
        if (stderr) console.error(stderr)

        console.log('Done.')

        resolve()
      }
    )
  })
}

async function buildAndUpload() {
  await Promise.all([
    make('HTML5', 'html5', 'index.html'),
    make('Windows Desktop', 'windows', `${projectName}.exe`),
    make('Mac OSX', 'mac', `${projectName}.zip`),
    make('Linux/X11', 'linux', projectName)
  ])
  
  // Itch upload
  console.log('\x1b[33m\x1b[1mUploading builds to itch...\x1b[0m')
  child_process.exec(`butler push ${path.join(dstPath, 'html5')} strutcode/indigo:html5`)
  child_process.exec(`butler push ${path.join(dstPath, 'windows')} strutcode/indigo:win`)
  child_process.exec(`butler push ${path.join(dstPath, 'mac')} strutcode/indigo:mac`)
  child_process.exec(`butler push ${path.join(dstPath, 'linux')} strutcode/indigo:linux`)
}

buildAndUpload()
