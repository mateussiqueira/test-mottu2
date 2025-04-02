import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { GetPokemonByIdUseCase } from '../domain/usecases/get-pokemon-by-id.usecase';
import { GetPokemonListUseCase } from '../domain/usecases/get-pokemon-list.usecase';
import { GetPokemonsByAbilityUseCase } from '../domain/usecases/get-pokemons-by-ability.usecase';
import { GetPokemonsByTypeUseCase } from '../domain/usecases/get-pokemons-by-type.usecase';
import { SearchPokemonUseCase } from '../domain/usecases/search-pokemon.usecase';
import { PokemonRepositoryImpl } from '../infrastructure/repositories/pokemon.repository.impl';
import { PokemonController } from '../presentation/controllers/pokemon.controller';

@Module({
  imports: [
    HttpModule,
    ConfigModule.forRoot({
      isGlobal: true,
    }),
  ],
  controllers: [PokemonController],
  providers: [
    PokemonRepositoryImpl,
    GetPokemonListUseCase,
    GetPokemonByIdUseCase,
    SearchPokemonUseCase,
    GetPokemonsByTypeUseCase,
    GetPokemonsByAbilityUseCase,
  ],
})
export class PokemonModule {}
