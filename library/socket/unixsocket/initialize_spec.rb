require_relative '../spec_helper'
require_relative '../fixtures/classes'

with_feature :unix_socket do
  describe 'UNIXSocket#initialize' do
    describe 'using a non existing path' do
      it 'raises Errno::ENOENT' do
        lambda { UNIXSocket.new(SocketSpecs.socket_path) }.should raise_error(Errno::ENOENT)
      end
    end

    describe 'using an existing socket path' do
      before do
        @path = SocketSpecs.socket_path
        @server = UNIXServer.new(@path)
      end

      after do
        @server.close
        rm_r(@path)
      end

      it 'returns a new UNIXSocket' do
        UNIXSocket.new(@path).should be_an_instance_of(UNIXSocket)
      end

      it 'sets the socket path to an empty String' do
        UNIXSocket.new(@path).path.should == ''
      end

      it 'sets the socket to binmode' do
        UNIXSocket.new(@path).binmode?.should be_true
      end
    end
  end
end
