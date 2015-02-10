phpunit単体テストツールをインストール

        $ wget https://phar.phpunit.de/phpunit.phar
        $ chmod +x phpunit.phar
        $ sudo mv phpunit.phar /usr/local/bin/phpunit
        $ phpunit --version

RemoteConnect.phpファイルを作成する

        <?php
        class RemoteConnect
        {
            public function connectToServer($serverName=null) {
                if($serverName==null){
                    throw new Exception(“That's not a server name!”);
            }
            $fp = fsockopen($serverName,80);
                return ($fp) ? true : false;
          }

            public function returnSampleObject() {
                return $this;
            }
        }
        ?>


RemoteConnectTest.phpファイルを作成して、connectToServer()関数をテストする

        <?php
        require_once('RemoteConnect.php');

        class RemoteConnectTest extends PHPUnit_Framework_TestCase
        {
            public function setUp(){ }
            public function tearDown(){ }

            public function testConnectionIsValid() {
                // test to ensure that the object from an fsockopen is valid
                $connObj = new RemoteConnect();
                $serverName = 'www.google.com';
                $this->assertTrue($connObj->connectToServer($serverName) !== false);
            }
        }
        ?>

テストを実行する

        $ phpunit RemoteConnectTest.php

setUp()とtearDown()関数は補助関数で、setUp()はすべてのテストの前に実行されて、

tearDown()はすべてのテストの後に実行される。fsockopen()は、ファイルポインタを返す。

失敗した場合はFALSEを返す。
