{ ... }:
# recommend using `hashedPassword`
{
  users.users.root = {
    openssh.authorizedKeys.keyFiles = [
      ../louis/id_gpgcard.pub
    ];
    hashedPassword = "$5$QsZT.BB2Z9dZsvR$om6JwqPng2iSibwkrhTr635YyAju1KTFaMOqLS8WPQ5";
  };
}
