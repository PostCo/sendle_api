# frozen_string_literal: true
require "spec_helper"

RSpec.describe SendleAPI::Order do
  let(:sender_contact) do
    SendleAPI::Contact.new(
      {
        name: "Andy 2",
        phone: "+61491570157",
        company: "KMart",
      }
    )
  end
  let(:sender_address) do
    SendleAPI::Address.new(
      {
        address_line1: "1 Clayton Road",
        suburb: "Clayton",
        state_name: "VIC",
        postcode: "3168",
        country: "Australia",
      }
    )
  end
  let(:sender) do
    SendleAPI::Sender.new(
      contact: sender_contact,
      address: sender_address,
      instructions: ""
    )
  end
  let(:receiver_contact) do
    SendleAPI::Contact.new(
      {
        name: "Andy 2",
        phone: "+61491570157",
        company: "KMart",
      }
    )
  end
  let(:receiver_address) do
    SendleAPI::Address.new(
      {
        address_line1: "13 Bushy Park Avenue",
        suburb: "Caroline Springs",
        state_name: "VIC",
        postcode: "3023",
        country: "Australia",
      }
    )
  end
  let(:receiver) do
    SendleAPI::Receiver.new(
      contact: receiver_contact,
      address: receiver_address,
      instructions: "none"
    )
  end
  let(:attributes) do
    {
      first_mile_option: "drop off",
      description: "apparel",
      customer_reference: "ReturnOrder:123",
      weight: { value: 0.5, units: "kg" },
      sender: sender,
      receiver: receiver,
    }
  end

  describe "validation" do
    subject { described_class.new(attributes) }

    context "success" do
      it do
        subject.save
        expect(subject.valid?).to be(true)
      end
    end

    context "failed" do
      let(:receiver) { {} }
      it do
        expect(subject.valid?).to be(false)
        expect(subject.errors.messages.keys).to include(/receiver/)
      end
    end
  end

  describe "#track" do
    subject { described_class.new }
    context "without sendle_reference in attributes" do
      it do
        expect { subject.track }.to raise_error(ArgumentError)
      end
    end
  end
end
