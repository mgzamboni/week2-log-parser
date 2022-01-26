require 'parser.rb'

describe Parser do
  let(:valid_file) { Parser.new 'spec/fixtures/game_test.log' }
  let(:invalid_file) { Parser.new 'invalid_folder/invalid_file.txt' }

  describe '#first_line' do
    context 'when valid file' do
      it 'checks if it returns a valid string' do
        expect(valid_file.first_line).to eql("  0:00 ------------------------------------------------------------\n")
      end
    end

    context 'when invalid file' do
      it 'checks if it returns a runtime error' do
        expect { invalid_file.first_line }.to raise_error(RuntimeError, 'file or directory not found')
      end
    end
  end

  describe '#gamelog_json' do
    context 'when valid file' do
      it 'checks if it returns a valid json with correrct info' do
        expect(valid_file.gamelog_json).to eql('{"game_test.log":{"lines":100,"players":["Isgalamido","Dono da Bola","Mocinha"]}}')
      end
    end

    context 'when invalid file' do
      it 'checks if it returns a runtime error' do
        expect { invalid_file.gamelog_json }.to raise_error(RuntimeError, 'file or directory not found')
      end
    end
  end
end
