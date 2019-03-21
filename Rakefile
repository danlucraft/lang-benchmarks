task :clean do
  sh "rm -f crystal/release"
  sh "rm -f nim/release"
  sh "rm -fr nim/nimcache"
  sh "rm -rf haxe/cpp_target"
  sh "rm -rf haxe/out"
  sh "rm -rf haxe/hl_native"
  sh "rm -f haxe/Main.hl"
  sh "rm -f rust/release"
end

task :build do
  puts "Versions:"
  puts "-------------"
  sh "nim -v"
  puts "-------------"
  sh "ruby -v"
  puts "-------------"
  sh "node -v"
  puts "-------------"
  sh "haxe --version"
  puts "-------------"
  sh "rustc --version"
  puts "-------------"
  sh "crystal -v"
  puts "-------------"

  sh "crystal build --release -o crystal/release crystal/reversi.cr"

  sh "nim compile -d:release nim/reversi.nim"
  sh "mv nim/reversi nim/release"

  Dir.chdir("haxe" ) do
    sh "haxe -main Main --cpp cpp_target"
    sh "haxe -main Main --hl Main.hl"
    sh "haxe -hl out/main.c -main Main"
    sh "gcc -O3 -o hl_native -std=c11 -I out out/main.c -Lhl /usr/local/lib/libhl.dylib"
  end

  sh "rustc rust/reversi.rs -o rust/release -C opt-level=3"
end

task :run do
  sh "time ./nim/release"
  puts
  sh "time ./crystal/release"
  puts
  sh "time node node/reversi.js"
  puts
  sh "time ruby ./ruby/reversi.rb"

  Dir.chdir("haxe" ) do
    sh "time haxe -main Main --interp"
    sh "time ./cpp_target/Main"
    sh "time hl Main.hl"
  end
  sh "time ./rust/release"
end
