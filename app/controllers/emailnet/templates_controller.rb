module Emailnet
  class TemplatesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :update

    def index
      templates
    end

    def show
      response = HTTParty.post(
        "https://auth.getbee.io/apiauth", body: {
        client_id: Emailnet.configuration.bee_client_id,
        client_secret: Emailnet.configuration.bee_client_secret
      })

      @jwt = response.body.to_s
      @template_json = EmailTemplate.find_by(identifier: params[:id])&.payload_json ||
        EmailTemplate.find_by(identifier: 'base_template')&.payload_json

      @merge_fields = templates.find { |template| template['id'] == params[:id] }['merge_fields']
      @special_links  = templates.find { |template| template['id'] == params[:id] }['special_links']
    end

    def update
      @template = Emailnet::EmailTemplate.find_by(identifier: params[:id]) ||
        Emailnet::EmailTemplate.new(identifier: params[:id])
      @template.payload_html = params[:htmlFile]
      @template.payload_json = params[:jsonFile]
      @template.save!
    end

    def templates
      @templates ||= YAML.load_file(Emailnet.configuration.definition_file)
    end
  end
end
