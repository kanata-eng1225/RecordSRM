module ApplicationHelper
  def default_meta_tags
    {
      site: 'RecordSRM',
      title: 'オススメのストレス解消法の共有と記録サービス',
      reverse: true,
      charset: 'utf-8',
      description: 'オススメのストレス解消法を実践・記録し、その効果をRecordSRMでチェック!',
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
        image: image_url('RecordSRM_OGP.jpg')
      }
    }
  end
end
