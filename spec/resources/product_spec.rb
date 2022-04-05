# frozen_string_literal: true
require "spec_helper"

RSpec.describe SendleAPI::Product do
  subject(:make_request) { described_class.find(:all, params: params) }

  let(:params) { {} }
  let(:valid_route) do
    {
      sender_address_line1: "22-40 Sir John Young Crescent",
      sender_suburb: "Woolloomooloo",
      sender_postcode: "2011",
      sender_country: "Australia",
      receiver_address_line1: "Building 3/92 Bell St",
      receiver_suburb: "Preston",
      receiver_postcode: "3072",
      receiver_country: "Australia",
      weight_units: "kg",
      weight_value: 0.5,

    }
  end
  let(:mismatch_suburb_and_postcode) do
    {
      sender_address_line1: "Unit 2 / 74 O'Donnell St.",
      sender_suburb: "Sydney",
      sender_postcode: "2026",
      sender_country: "Australia",
      receiver_address_line1: "Building 3/92 Bell St",
      receiver_suburb: "Preston",
      receiver_postcode: "3072",
      receiver_country: "Australia",
      weight_units: "kg",
      weight_value: 0.5,
    }
  end
  let(:not_serviceable_route) do
    {
      sender_address_line1: "4 Jones Avenue",
      sender_suburb: "Upper Ferntree Gully",
      sender_postcode: "2026",
      sender_country: "Australia",
      receiver_address_line1: "Building 3/92 Bell St",
      receiver_suburb: "Preston",
      receiver_postcode: "3072",
      receiver_country: "Australia",
      weight_units: "kg",
      weight_value: 0.5,
    }
  end
  let(:po_box_route) do
    {
      sender_address_line1: "Parcel Locker 10162 64698",
      sender_suburb: "Haymarket",
      sender_postcode: "2000",
      sender_country: "Australia",
      receiver_address_line1: "Building 3/92 Bell St",
      receiver_suburb: "Preston",
      receiver_postcode: "3072",
      receiver_country: "Australia",
      weight_units: "kg",
      weight_value: 0.5,
    }
  end

  describe "#find" do
    context "success" do
      let(:params) { valid_route }

      it do
        expect(make_request.length).to be > 0
      end
    end

    describe "invalid request" do
      context "suburb doesn't match postcode" do
        let(:params) { mismatch_suburb_and_postcode }
        it do
          expect { make_request }.to raise_error(ActiveResource::ResourceInvalid)
        end
      end

      context "not serviceable route" do
        let(:params) { not_serviceable_route }
        it do
          expect { make_request }.to raise_error(ActiveResource::ResourceInvalid)
        end
      end

      context "po box route" do
        let(:params) { po_box_route }
        it do
          expect { make_request }.to raise_error(ActiveResource::ResourceInvalid)
        end
      end
    end
  end
end
