<?php
namespace App\Jwt;

use App\Controllers\Controller;
use Slim\Psr7\Request;
use Slim\Psr7\Response;

class JwtInvalidator extends Controller
{
    public function invalidate(Request $request, Response $response, array $args)
    {
        $token = $request->getAttribute("encoded_token");
        $query = "INSERT INTO InvalidJWT VALUES ('$token')";
        $this->db->query($query);
    }

    public function isValid($token) {
        $query = "SELECT * FROM InvalidJWT WHERE Token = '$token'";
        $result = $this->db->query($query);
        return mysqli_num_rows($result) == 0;
    }
}
?>