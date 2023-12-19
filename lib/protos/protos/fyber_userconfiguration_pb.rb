# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: protos/fyber_userconfiguration.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("protos/fyber_userconfiguration.proto", :syntax => :proto3) do
    add_message "FYBER.userconfiguration.Account" do
      optional :id, :string, 1
      optional :balance, :double, 2
      optional :currency, :string, 3
    end
    add_message "FYBER.userconfiguration.Transaction" do
      optional :id, :string, 1
      optional :amount, :double, 2
      optional :currency, :string, 3
    end
    add_message "FYBER.userconfiguration.Accounts" do
      repeated :accounts, :message, 1, "FYBER.userconfiguration.Account"
    end
    add_message "FYBER.userconfiguration.Transactions" do
      repeated :transactions, :message, 1, "FYBER.userconfiguration.Transaction"
    end
  end
end

module FYBER
  module Userconfiguration
    Account = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("FYBER.userconfiguration.Account").msgclass
    Transaction = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("FYBER.userconfiguration.Transaction").msgclass
    Accounts = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("FYBER.userconfiguration.Accounts").msgclass
    Transactions = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("FYBER.userconfiguration.Transactions").msgclass
  end
end
