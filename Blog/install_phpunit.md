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


RemoteConnectTest.phpファイルを作成して、connectToServer()関数をテストする。
テストケースのクラス名RemoteConnectの後ろにTestをつける.

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

ユニットテストに$_POST情報の使い方は[このリンク](http://stackoverflow.com/questions/2722897/post-parameters-to-phpunit-test)に紹介されています。

テストケースに引数を渡したいときに`@dataProvider`アノテーションを使います。

        <?php
        class DataTest extends PHPUnit_Framework_TestCase
        {
            /**
             * @dataProvider additionProvider
             */
            public function testAdd($a, $b, $expected)
            {
                $this->assertEquals($expected, $a + $b);
            }

            public function additionProvider()
            {
                return array(
                  array(0, 0, 0),
                  array(0, 1, 1),
                  array(1, 0, 1),
                  array(1, 1, 3)
                );
            }
        }
        ?>

上の例ではtestAddに渡したいパラメータは`@dataProvider`を通して、データのプロバイダ`additionProvider()`関数を指定しています.

