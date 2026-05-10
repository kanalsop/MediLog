import Foundation

struct LegalDocument: Identifiable {
    let id: String
    let title: String
    let effectiveDate: String
    let sections: [LegalDocumentSection]
}

struct LegalDocumentSection: Identifiable {
    let id: String
    let title: String
    let body: String
}

extension LegalDocument {
    static let termsOfUse = LegalDocument(
        id: "terms-of-use",
        title: "利用規約",
        effectiveDate: "制定日: 2026年5月10日",
        sections: [
            LegalDocumentSection(
                id: "purpose",
                title: "1. 本規約について",
                body: "本規約は、MediLogを利用する際の条件を定めるものです。本アプリを利用した場合、ユーザーは本規約に同意したものとみなされます。"
            ),
            LegalDocumentSection(
                id: "service",
                title: "2. 本アプリの内容",
                body: "本アプリは、ユーザーが登録した薬、服用予定時刻、服用記録を管理するための補助ツールです。本アプリは医療行為、診断、治療、投薬指示、薬学的助言を提供するものではありません。"
            ),
            LegalDocumentSection(
                id: "medical",
                title: "3. 医療上の判断",
                body: "薬の服用方法、服用量、服用時刻、飲み忘れ時の対応、服用の中止や変更については、必ず医師、薬剤師、その他の医療専門家の指示に従ってください。本アプリの表示や通知のみを根拠として医療上の判断を行わないでください。"
            ),
            LegalDocumentSection(
                id: "responsibility",
                title: "4. ユーザーの責任",
                body: "ユーザーは、登録内容が正確であることを自身で確認し、必要に応じて更新するものとします。通知の許可、端末の時刻設定、マナーモード、集中モード、バッテリー状態などにより、通知が届かない、または遅れる場合があります。"
            ),
            LegalDocumentSection(
                id: "prohibited",
                title: "5. 禁止事項",
                body: "ユーザーは、本アプリを不正な目的で利用する行為、第三者の権利を侵害する行為、本アプリの動作を妨害する行為、法令または公序良俗に反する行為をしてはなりません。"
            ),
            LegalDocumentSection(
                id: "changes",
                title: "6. 変更・中断",
                body: "本アプリの機能、表示内容、仕様は、改善や保守のため予告なく変更、中断、終了される場合があります。"
            ),
            LegalDocumentSection(
                id: "disclaimer",
                title: "7. 免責事項",
                body: "本アプリは、正確性、完全性、有用性、特定目的への適合性を保証するものではありません。本アプリの利用により生じた損害について、法令上認められる範囲で責任を負いません。"
            ),
            LegalDocumentSection(
                id: "law",
                title: "8. 準拠法",
                body: "本規約は日本法に準拠します。"
            )
        ]
    )

    static let privacyPolicy = LegalDocument(
        id: "privacy-policy",
        title: "プライバシーポリシー",
        effectiveDate: "制定日: 2026年5月10日",
        sections: [
            LegalDocumentSection(
                id: "overview",
                title: "1. 基本方針",
                body: "MediLogは、服薬管理に関する情報がユーザーにとって重要な情報であることを認識し、プライバシーに配慮して取り扱います。"
            ),
            LegalDocumentSection(
                id: "stored-data",
                title: "2. アプリ内で扱う情報",
                body: "本アプリでは、ユーザーが入力した薬の名前、服用予定時刻、服用量、服用済み・スキップなどの記録、通知音やテーマなどの設定情報を端末内に保存します。"
            ),
            LegalDocumentSection(
                id: "collection",
                title: "3. 外部送信",
                body: "現時点で、本アプリは独自のサーバーへユーザーの服薬情報を送信しません。ユーザーの入力内容を、広告配信や第三者への販売のために利用することもありません。"
            ),
            LegalDocumentSection(
                id: "notifications",
                title: "4. 通知",
                body: "本アプリは、ユーザーが登録した服用予定に基づき、端末のローカル通知機能を利用します。通知の表示可否や通知音の扱いは、端末の通知設定、集中モード、マナーモードなどの影響を受けます。"
            ),
            LegalDocumentSection(
                id: "os",
                title: "5. 端末・OSによる処理",
                body: "端末のバックアップ、診断情報、クラッシュログ、通知基盤など、OSやApp Storeが提供する機能により情報が処理される場合があります。これらはApple等の各サービス提供者の規約およびプライバシーポリシーに従って扱われます。"
            ),
            LegalDocumentSection(
                id: "management",
                title: "6. 情報の管理",
                body: "保存された情報は、原則としてユーザーの端末内で管理されます。端末の紛失、共有、バックアップ設定、削除操作には十分注意してください。"
            ),
            LegalDocumentSection(
                id: "deletion",
                title: "7. 削除",
                body: "ユーザーは、アプリ内の操作またはアプリのアンインストールにより、端末内に保存された情報を削除できます。ただし、端末やOSのバックアップに残る情報については、各設定に従って管理してください。"
            ),
            LegalDocumentSection(
                id: "changes",
                title: "8. 変更",
                body: "本ポリシーは、機能追加、法令変更、運用上の必要に応じて変更される場合があります。重要な変更がある場合は、アプリ内で分かりやすい方法により案内します。"
            )
        ]
    )

    static let licenses = LegalDocument(
        id: "licenses",
        title: "ライセンス",
        effectiveDate: "最終更新日: 2026年5月10日",
        sections: [
            LegalDocumentSection(
                id: "sound-effects",
                title: "効果音について",
                body: "本アプリで使用している一部の効果音は ElevenLabs Sound Effects により生成されています。\n\nAttribution: elevenlabs.io"
            ),
            LegalDocumentSection(
                id: "cat-mascot",
                title: "猫キャラクター画像について",
                body: "本アプリで使用している猫キャラクター画像はAIにより生成されています。制作時の参考として Catppuccin の猫アイコンを参照しています。\n\nCatppuccin is licensed under the MIT License.\nCopyright © 2021-present Catppuccin Org\nhttps://github.com/catppuccin/catppuccin"
            ),
            LegalDocumentSection(
                id: "third-party-libraries",
                title: "外部ライブラリ",
                body: "現在、アプリ内で表示が必要な外部ライブラリのライセンス情報はありません。今後、外部ライブラリや素材を追加した場合は、この画面にライセンス情報を掲載します。"
            )
        ]
    )
}
