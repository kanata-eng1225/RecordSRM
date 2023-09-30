module ApplicationHelper
  def default_meta_tags
    {
      site: 'RecordSRM',
      title: 'オススメのストレス解消法の共有と記録サービス',
      reverse: true,
      charset: 'utf-8',
      description: 'RecordSRMで、オススメのストレス解消法を共有・実施し、自己の方法も記録。効果を数値で確認し、新しい解消法の発見と効果的なストレス対策をサポートします。',
      keywords: 'ストレス,ストレス解消,ストレスマネージメント',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('RecordSRM_OGP.jpg'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        # site: '@YourTwitterHandle',
        image: image_url('RecordSRM_OGP.jpg')
      }
    }
  end
end
