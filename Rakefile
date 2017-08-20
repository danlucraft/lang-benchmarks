task :clean do
  sh "rm -f reversi/reversi_crystal_release"
  sh "rm -f reversi/reversi_crystal_dev"
  sh "rm -f reversi/reversi_nim"
end

task :build do
  sh "crystal -v"
  sh "crystal build --release -o reversi/reversi_crystal_release reversi/reversi.cr"
  sh "crystal build -o reversi/reversi_crystal_dev reversi/reversi.cr"

  sh "nim -v"
  sh "nim compile -d:release reversi/reversi.nim"
  sh "mv reversi/reversi reversi/reversi_nim_release"

  sh "ruby -v"
  sh "node -v"
end

task :run do
  sh "time ./reversi/reversi_nim_release"
  puts
  sh "time ./reversi/reversi_crystal_release"
  puts
  sh "time node reversi/reversi.js"
  puts
  sh "time ./reversi/reversi_crystal_dev"
  puts
  sh "time ruby ./reversi/reversi.rb"
end
