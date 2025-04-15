local EggHatcherCalculator = {}

-- Function to calculate how many eggs can be hatched
function EggHatcherCalculator:Calculate(playerCurrency, eggCost, desiredQuantity)
    local maxEggs = math.floor(playerCurrency / eggCost)
    local totalCost = eggCost * desiredQuantity
    
    local result = {
        canAfford = maxEggs >= desiredQuantity,
        maxPossible = maxEggs,
        totalCost = totalCost,
        remaining = playerCurrency - totalCost
    }
    
    return result
end

-- Create the GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CurrencyInput = Instance.new("TextBox")
local EggCostInput = Instance.new("TextBox")
local QuantityInput = Instance.new("TextBox")
local CalculateButton = Instance.new("TextButton")
local ResultLabel = Instance.new("TextLabel")

-- GUI Properties
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

Title.Text = "Egg Hatcher Calculator"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

CurrencyInput.PlaceholderText = "Enter your currency"
EggCostInput.PlaceholderText = "Enter egg cost"
QuantityInput.PlaceholderText = "Enter quantity desired"

CalculateButton.Text = "Calculate"
CalculateButton.Size = UDim2.new(0.5, 0, 0, 40)
CalculateButton.Position = UDim2.new(0.25, 0, 0.7, 0)

-- Calculate button click handler
CalculateButton.MouseButton1Click:Connect(function()
    local currency = tonumber(CurrencyInput.Text) or 0
    local cost = tonumber(EggCostInput.Text) or 0
    local quantity = tonumber(QuantityInput.Text) or 0
    
    local result = EggHatcherCalculator:Calculate(currency, cost, quantity)
    
    if result.canAfford then
        ResultLabel.Text = string.format(
            "You can afford %d eggs!\nTotal cost: %d\nRemaining currency: %d",
            quantity, result.totalCost, result.remaining
        )
    else
        ResultLabel.Text = string.format(
            "Not enough currency!\nMax eggs possible: %d\nYou need %d more currency",
            result.maxPossible, result.totalCost - currency
        )
    end
end)

return EggHatcherCalculator