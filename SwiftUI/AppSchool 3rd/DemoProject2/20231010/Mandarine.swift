import SwiftUI

struct Mandarine: View {
	
	@State private var purchasingAmount: Int?
	@State private var boxCapacity: Int?
	@State private var result: (Int, Int)?
	
	var body: some View{
		VStack {
			TextField("구입할 귤", value: $purchasingAmount, format: .number)
				.textFieldStyle(.roundedBorder)
				.onChange(of: purchasingAmount) { newValue in
					result = getResult(newValue, boxCapacity)
				}
			TextField("박스 용량", value: $boxCapacity, format: .number)
				.textFieldStyle(.roundedBorder)
				.onChange(of: boxCapacity) { newValue in
					result = getResult(purchasingAmount, newValue)
				}
			
			Text("박스에 담길 수량 \(result?.0 ?? 0)\n남은 귤 \(result?.1 ?? 0)")
				.padding(.vertical, 20)
		}
		.padding()
	}
	
	func getResult(_ amount: Int?, _ boxCap: Int?) -> (Int, Int) {
		
		guard let amount = amount, let boxCap = boxCap else { return (0,0) }
		let answer: Int = amount / boxCap
		let leftOver: Int = amount % boxCap
		return (answer, leftOver)
	}
}

#Preview {
	Mandarine()
}
