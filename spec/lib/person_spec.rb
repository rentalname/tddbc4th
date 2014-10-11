describe Person do
  let(:taro) { Person.new(family_name: "佐藤", first_name: "太郎", gender: :male, birthday: Date.new(1996, 10, 11)) }
  let(:hanako) { Person.new(family_name: "山田", first_name: "花子", gender: :female, birthday: Date.new(1994, 7, 30))}

  context "佐藤太郎" do
    it "名字を取得できる" do
      expect(taro.family_name).to eq "佐藤"
    end
    it "名前を取得できる" do
      expect(taro.first_name).to eq "太郎"
    end
    it "氏名を取得できる" do
      expect(taro.full_name).to eq "佐藤太郎"
    end
    it "男性である" do
      expect(taro).to be_male
    end
    it "女性ではない" do
      expect(taro).not_to be_female
    end
    it "山田花子と結婚できる" do
      expect(taro.can_marry?(hanako)).to be_truthy
    end
    it "田中小次郎と結婚できない" do
      koziro = Person.new(family_name: "田中", first_name: "小次郎", gender: :male, birthday: Date.new(1990, 1, 20))
      expect(taro.can_marry?(koziro)).to be_falsy
    end
    it "生年月日は1996/10/11" do
      expect(taro.birthday).to eq Date.new(1996, 10, 11)
    end
  end

  context "山田花子" do
    it "女性である" do
      expect(hanako).to be_female
    end
    it "男性ではない" do
      expect(hanako).not_to be_male
    end
    it "佐藤太郎と結婚できる" do
      expect(hanako.can_marry?(taro)).to be_truthy
    end
    it "女性とは結婚できない" do
      akiko = Person.new(family_name: "斉藤", first_name: "明子", gender: :female, birthday: Date.new(2001, 6, 3))
      expect(hanako.can_marry?(akiko)).to be_falsy
    end
    it "生年月日は1994/7/30" do
      expect(hanako.birthday).to eq Date.new(1994, 7, 30)
    end
  end

  describe "コンストラクタに渡す引数" do
    context "名前に数字を渡した場合" do
      it "名前に50が入る" do
        tanaka50 = Person.new(family_name: '田中', first_name: 50, gender: :female, birthday: Date.new(1950, 11, 19))
        expect(tanaka50.first_name).to eq "50"
      end
    end
    context "名字に数字を渡した場合" do
      it "名字に77が入る" do
        tarou77 = Person.new(family_name: 77, first_name: 'tarou', gender: :male, birthday: Date.new(1977, 8, 30))
        expect(tarou77.family_name).to eq '77'
      end
    end
  end

  describe "エラー条件" do
    shared_examples "コンストラクタでエラーが出ること" do
      it { expect{ Person.new(family_name: family_name, first_name: first_name, gender: gender, birthday: birthday) }.to raise_error ArgumentError }
    end
    let(:family_name){ "佐藤" }
    let(:first_name){ "太郎" }
    let(:gender) { :male }
    let(:birthday) { Date.new(1996, 10, 11) }
    it "キーワード引数を渡さなかった場合にもエラーが出る" do
      expect{ Person.new("","","") }.to raise_error ArgumentError
    end
    context "名字が空文字列の場合" do
      let(:family_name){ "" }
      it_behaves_like "コンストラクタでエラーが出ること"
    end
    context "名前が空文字列の場合" do
      let(:first_name){ "" }
      it_behaves_like "コンストラクタでエラーが出ること"
    end
    context "名字と名前が空文字列の場合" do
      let(:family_name){ "" }
      let(:first_name){ "" }
      it_behaves_like "コンストラクタでエラーが出ること"
    end
    context "名前が空白文字の場合" do
      let(:first_name){ " " }
      it_behaves_like "コンストラクタでエラーが出ること"
    end
    context "名字が空白文字の場合" do
      let(:family_name){ " " }
      it_behaves_like "コンストラクタでエラーが出ること"
    end
    context "名字にnilを渡した場合" do
      let(:family_name){ nil }
      it_behaves_like "コンストラクタでエラーが出ること"
    end
    context "名前にnilを渡した場合" do
      let(:first_name){ nil }
      it_behaves_like "コンストラクタでエラーが出ること"
    end
    context "性別にnilを渡した場合" do
      let(:gender){ nil }
      it_behaves_like "コンストラクタでエラーが出ること"
    end
    context "性別に:male,:female以外を渡した場合" do
      let(:gender){ :unknown }
      it_behaves_like "コンストラクタでエラーが出ること"
    end
  end
end
