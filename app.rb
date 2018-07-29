# app.rb
require "sinatra"
require 'sinatra/activerecord'
require 'fillable-pdf'

class App < Sinatra::Base
  get "/" do
    erb :index
  end

  get "/pdf" do
    File.delete('form.pdf') if File.exist?('form.pdf')

    pdf = FillablePDF.new 'final_form.pdf'
    path = params['path']

    c1 = params['code1']
    c2 = params['code2']
    c3 = params['code3']
    c4 = params['code4']
    c5 = params['code5']

    s1 = params['school1']
    s2 = params['school2']
    s3 = params['school3']
    s4 = params['school4']
    s5 = params['school5']


    pdf.set_field(:untitled1, path)
    pdf.set_field(:untitled2, s1)
    pdf.set_field(:untitled3, c1)
    pdf.set_field(:untitled4, path)
    pdf.set_field(:untitled5, s2)
    pdf.set_field(:untitled6, c2)
    pdf.set_field(:untitled7, path)
    pdf.set_field(:untitled8, s3)
    pdf.set_field(:untitled9, c3)
    pdf.set_field(:untitled10, path)
    pdf.set_field(:untitled11, s4)
    pdf.set_field(:untitled12, c4)
    pdf.set_field(:untitled13, path)
    pdf.set_field(:untitled14, s5)
    pdf.set_field(:untitled15, c5)
    pdf.save_as('form.pdf')

    headers "Content-Disposition" => "attachment", "Content-Type" => "application/pdf"

    send_file(File.open('form.pdf'), :disposition => 'attachment', :filename => 'form.pdf')
  end
end
