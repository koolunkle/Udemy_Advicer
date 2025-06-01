import 'package:advicer/data/datasources/advice_datasource_remote.dart';
import 'package:advicer/data/exceptions/exceptions.dart';
import 'package:advicer/data/models/advice_model.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advice_datasource_remote_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceDatasourceRemote', () {
    group('should return AdviceModel', () {
      test('when Client response was 200 and has valid data', () async {
        final mockClient = MockClient();
        final adviceDatasourceRemoteUnderTest = AdviceDatasourceRemoteImpl(
          client: mockClient,
        );
        const responseBody = '{"advice": "test advice", "advice_id": 1}';

        when(
          mockClient.get(
            Uri.parse('https://api.flutter-community.com/api/v1/advice'),
            headers: {'accept': 'application/json'},
          ),
        ).thenAnswer(
          (realInvocation) => Future.value(Response(responseBody, 200)),
        );

        final result =
            await adviceDatasourceRemoteUnderTest.getRandomAdviceFromApi();
        expect(result, AdviceModel(advice: 'test advice', id: 1));
      });
    });

    group('should throw', () {
      test('a ServerException when Client response was not 200', () {
        final mockClient = MockClient();
        final adviceDatasourceRemoteUnderTest = AdviceDatasourceRemoteImpl(
          client: mockClient,
        );

        when(
          mockClient.get(
            Uri.parse('https://api.flutter-community.com/api/v1/advice'),
            headers: {'accept': 'application/json'},
          ),
        ).thenAnswer((realInvocation) => Future.value(Response('', 201)));

        expect(
          adviceDatasourceRemoteUnderTest.getRandomAdviceFromApi,
          throwsA(isA<ServerException>()),
        );
      });

      test(
        'a Type Error when Client response was 200 and has no valid data',
        () {
          final mockClient = MockClient();
          final adviceDatasourceRemoteUnderTest = AdviceDatasourceRemoteImpl(
            client: mockClient,
          );
          const responseBody = '{"advice": "test_advice"}';

          when(
            mockClient.get(
              Uri.parse('https://api.flutter-community.com/api/v1/advice'),
              headers: {'accept': 'application/json'},
            ),
          ).thenAnswer(
            (realInvocation) => Future.value(Response(responseBody, 200)),
          );

          expect(
            adviceDatasourceRemoteUnderTest.getRandomAdviceFromApi,
            throwsA(isA<TypeError>()),
          );
        },
      );
    });
  });
}
