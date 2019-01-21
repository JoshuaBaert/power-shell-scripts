param (
    [switch] $v = $false
)

if($v) {
    docker-compose up 
} else {
    docker-compose up -d
}