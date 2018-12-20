function chls { choco list --local-only }
function chin { 
    $str = ''
    for ($i = 0; $i -lt $args.Count; $i++) { $str += " " + $args[$i] }
    choco install -y $str
} 